function [class,model] = libsvm( testing, training, training_class, options, testing_class )
    if nargin < 5
        testing_class = rand(length(testing),1); % random labels
    end

    model = svmtrain( training_class, training, options );    
    class = svmpredict( testing_class, testing, model, '-b 0' );
end