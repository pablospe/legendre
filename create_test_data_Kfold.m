function [tests,indices] = create_test_data_Kfold( db, m, degree, k, indices )
%     if ~exist('indices ', 'var')
%         indices = [];
%     end
    
    if( isempty(indices) )
        N = db.size;
        indices = crossvalind('Kfold', N, k);
    end
    
    
    for i = 1:k
        test = (indices == i);
        train = ~test;
        tests{i} = test_data( db, m, degree, train, test );
    end
end