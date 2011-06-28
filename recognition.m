function recognition( curve_features, db )
    training = [];
    for i=1:20
        training = [ training; db{i} ];
    end

    group = [[1:10], [1:10]];

    sample = curve_features;
    % for i=21:30
    %     r = randi([21 30],1);
    % %     sample = [ sample; db{ r } ];
    %     sample = [ sample; db{ i } ];
    % end

    class = knnclassify(sample, training, group)
end