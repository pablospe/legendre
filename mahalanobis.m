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
            train{current_label} = normalization( training(i,:) );
        else
            train{current_label} = [train{current_label}; normalization( training(i,:) ) ] ;
        end
    end 
    
    labels = keys(sizes);
    Nk = length(labels);
    pattern = [];
    sigma = [];
    for k=1:length(labels)
        current_label = labels{k};
        pattern{k} = mean( train{current_label} ); % pattern
        sigma{k} = cov( train{current_label} );    % covarianza matrix
    end

    N = length(testing);
    class = [];
    for i=1:N
        for k=1:Nk
            d(k) = distance_mahalanobis( testing(i,:), pattern{k}, sigma{k} );
        end
        [C,I] = min(d);
        class = [class; labels{I} ];
    end
end

function x = normalization( x )
%     u = mean(x);
%     des = sqrt(var(x));
%     x = (x-u)/des;
    x = x;
end


function u = pattern( train )
    N = length(train);
    for i=1:N
        if i == 1
            sum = train(i,:);
        else
            sum = sum + train(i,:);
        end
    end
    u = sum/N;
end


function d = distance_mahalanobis( x, pattern, sigma )
    d = (x-pattern)*pinv(sigma)*(x-pattern)';
end
