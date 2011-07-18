function class = run_single_test( t, d, method, options )
    switch(method)
      case MethodRecog.euclidean
          class = knnclassify(t.testing{d}, t.training{d}, t.training_class{d}, 1, 'euclidean' );
      case MethodRecog.cityblock
          class = knnclassify(t.testing{d}, t.training{d}, t.training_class{d}, 1, 'cityblock' );
      case MethodRecog.mahalanobis
          class = classify(t.testing{d}, t.training{d}, t.training_class{d}, 'mahalanobis' );
%           class = mahalanobis(t.testing{d}, t.training{d}, t.training_class{d} );
      case MethodRecog.libsvm
          class = libsvm(t.testing{d}, t.testing_class{d}, t.training{d}, t.training_class{d}, options );
    end        
end