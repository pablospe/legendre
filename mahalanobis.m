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
        class = [class; I ];
    end
end

function d = distance_mahalanobis( x, pattern, pinv_sigma )
    d = (x-pattern)*pinv_sigma*(x-pattern)';
end
