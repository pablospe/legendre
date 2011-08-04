function [tests,indices] = create_test_data( method, db, m, degree, k, percentaje )
    if nargin < 6
        percentaje = 0.9;
    end

    N = db.size;

    indices = [];
    
    switch(method)
      case MethodCrossVal.HoldOut
        [train, test] = crossvalind('HoldOut', N, 1-percentaje );
        
        for i = 1:k
            tests{i} = test_data( db, m, degree, train, test );
        end
      
      case MethodCrossVal.Kfold
        indices = crossvalind('Kfold', N, k);
    
        for i = 1:k
            test = (indices == i);
            train = ~test;
            tests{i} = test_data( db, m, degree, train, test );
        end
    end
end
