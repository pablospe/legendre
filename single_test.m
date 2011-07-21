function class = single_test( testing, training, training_class, method, options, testing_class )
    if nargin < 5
        options = '-c 512 -g 256 -e 1 -h 0 -b 0 -q';
    end

    if nargin < 6
        testing_class = rand(length(testing),1); % random labels
    end    
    
    switch(method)
      case MethodRecog.euclidean
          class = knnclassify( testing, training, training_class, 1, 'euclidean' );
      case MethodRecog.cityblock
          class = knnclassify( testing, training, training_class, 1, 'cityblock' );
      case MethodRecog.mahalanobis
          class = classify( testing, training, training_class, 'mahalanobis' );
%           class = mahalanobis(t.testing{d}, t.training{d}, t.training_class{d} );
      case MethodRecog.libsvm
          class = libsvm( testing, training, training_class, options, testing_class );
      case MethodRecog.minkowski           
          P = options;
          kdtreeNS = KDTreeSearcher(training,'Distance','minkowski','P',P);
          [IDX,D] = knnsearch(kdtreeNS, testing);
          class = training_class(IDX,:);
    end        
end