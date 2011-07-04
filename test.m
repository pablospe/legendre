%%
i=2;
f{i} = feature_extraction_db(db_splited, 10, i);
i=3;
f{i} = feature_extraction_db(db_splited, 10, i);
i=6;
f{i} = feature_extraction_db(db_splited, 10, i);
i=9;
f{i} = feature_extraction_db(db_splited, 10, i);
i=10;
f{i} = feature_extraction_db(db_splited, 10, i);


%%
i=1;
x = db2{i}.channel{1};
y = db2{i}.channel{2};
curves_features = feature_extraction( x, y, 10 );


%%
    training = [];
    for i=[2 3 6 9 10]
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

