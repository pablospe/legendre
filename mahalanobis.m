function class = mahalanobis( testing, training, training_class )
    [gindex,groups] = grp2idx(training_class);
    ngroups = length(groups);

    pattern = [];
    sigma = [];
    for k = 1:ngroups
        train = training(gindex==k, :);
        pattern{k} = mean(train);           % pattern
        pinv_sigma{k} = pinv(cov(train));   % pinv( covarianza_matrix )
    end

    N = length(testing);
    class = [];
    for i=1:N
        for k=1:ngroups
            d(k) = distance_mahalanobis( testing(i,:), pattern{k}, pinv_sigma{k} );
        end
        [C,I] = min(d);
        class = [class; groups{I} ];
    end
end

function d = distance_mahalanobis( x, pattern, pinv_sigma )
    d = (x-pattern)*pinv_sigma*(x-pattern)';
end


function x = normalization( x )
    u = mean(x);
    des = sqrt(var(x));
    x = (x-u)/des;
end


% Equivalente a "mean()"
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

