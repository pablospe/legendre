function result = run_test( test_data, method, options )
    if nargin < 3
        options = '';
    end

    N = length(test_data);  
    result = [];
    for i=1:N
        t = test_data{i};
        current_result = [];
        for d=t.degree
            class = run_test_current( t, d, method, options );
            recognition = 100 * sum(class == t.testing_class{d}) / length(class);
            
            current_result = [ current_result; [d recognition]];
        end
        
        if isempty(result)
            result = current_result./N;
        else
            result = result + current_result./N;
        end
    end
end


function class = run_test_current( t, d, method, options )
    switch(method)
      case MethodRecog.euclidean
          class = knnclassify(t.testing{d}, t.training{d}, t.training_class{d}, 1, 'euclidean' );
      case MethodRecog.cityblock
          class = knnclassify(t.testing{d}, t.training{d}, t.training_class{d}, 1, 'cityblock' );
      case MethodRecog.mahalanobis
%           class = classify(t.testing{d}, t.training{d}, t.training_class{d}, 'mahalanobis' );
          class = mahalanobis(t.testing{d}, t.training{d}, t.training_class{d} );
      case MethodRecog.libsvm
          class = libsvm(t.testing{d}, t.testing_class{d}, t.training{d}, t.training_class{d}, options );
    end        
end
