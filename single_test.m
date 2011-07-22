function class = single_test( testing, training, training_class, method, options, testing_class )
    if nargin < 5
        options = '-c 512 -g 256 -e 1 -h 0 -b 0 -q';
    end

    if nargin < 6
        testing_class = rand(length(testing),1); % random labels
    end    
    
    training = normalize( training );
    testing  = normalize( testing );
    
    switch(method)
      case MethodRecog.euclidean
          class = knnclassify( testing, training, training_class, 1, 'euclidean' );
      case MethodRecog.cityblock
          class = knnclassify( testing, training, training_class, 1, 'cityblock' );
      case MethodRecog.mahalanobis
%           class = classify( testing, training, training_class, 'mahalanobis' );
          class = mahalanobis(testing, training, training_class );
      case MethodRecog.libsvm
          class = libsvm( testing, training, training_class, options, testing_class );
      case MethodRecog.minkowski           
          P = options;
%           NS = KDTreeSearcher(training,'Distance','minkowski','P',P);
%           NS =  ExhaustiveSearcher(training,'Distance','minkowski','P',P);
%           IDX = NS.knnsearch(testing);
%           class = training_class(IDX,:);
          
          
          IDX = knnsearch( training, testing, ...
                           'NSMethod', 'kdtree', ...
                           'Distance','minkowski','P',P);
          class = training_class(IDX,:);
          
    end        
end


function x = normalize( x )
    x = x';  % If A is a matrix, mean(A) treats the columns of A as vectors
    
    mn = mean(x);
    sd = std(x);
    sd(sd==0) = 1;
    
    x = bsxfun(@minus,x,mn);
    x = bsxfun(@rdivide,x,sd);
    
    x = x';
end
