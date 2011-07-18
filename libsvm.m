function [class,model] = libsvm( testing, testing_class, training, training_class, options )
%     options = '-c 128 -g 256 -e 1 -h 0 -b 0 -q';   % optimo ?
%     options = '-c 1024 -g 128 -e 1 -h 0 -b 0 -q';  % test

    model = svmtrain( double(training_class), training, options );
    
    testing_class = rand(length(testing),1); % random labels
    predict_label = svmpredict( double(testing_class), testing, model, '-b 0' );
    class = char(predict_label);
end