function class = mahalanobis( testing, training, training_class )
    train = [];

    N = length(training);

    sizes = containers.Map;   % label -> number of sizes
    for i=1:N
        % Current label
        current_label = training_class(i);

        % create "sizes" size map
        if  sizes.isKey( current_label ) == 0
            sizes( current_label ) = 1;
        else
            sizes( current_label ) = sizes( current_label ) + 1;
        end        
    
        % separate "train" data into labels
        if sizes(current_label) == 1
            train{current_label} = training(i,:);
        else
            train{current_label} = [train{current_label}; training(i,:)];
        end
    end
    
    labels = keys(sizes);
    
     disp(train);
    
end