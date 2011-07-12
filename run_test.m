function result = run_test( test_data, method )
    N = length(test_data);  
    result = [];
    for i=1:N
        t = test_data{i};
        current_result = [];
        for d=3:20
            class = run_test_current( t, d, method );
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


function class = run_test_current( t, d, method )
    switch(method)
      case MethodRecog.euclidean
          class = knnclassify(t.testing{d}, t.training{d}, t.training_class{d}, 1, 'euclidean' );
      case MethodRecog.cityblock
          class = knnclassify(t.testing{d}, t.training{d}, t.training_class{d}, 1, 'cityblock' );
      case MethodRecog.mahalanobis
%           class = classify(t.testing{d}, t.training{d}, t.training_class{d}, 'mahalanobis' );
            class = mahalanobis(t.testing{d}, t.training{d}, t.training_class{d} );
    end        
end