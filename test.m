


%%
i=1;
x = db2{i}.channel{1};
y = db2{i}.channel{2};
curves_features = feature_extraction( x, y, 10 );


%%

% N = length(db_splited);
N = 110;

    training = [];
    group = [];
    for label=[2 3 6 9 10]   % single-stoke
        for i=1:N
            training = [ training; db_splited{label,i}.features ];
            group = [ group; mod(label,10) ];
        end
    end

%     group = [[1:10], [1:10]];

    sample = [];
    for i=1:N
        sample = [ sample; db_splited_testing{9,i}.features ];
    end
    
    % for i=21:30
    %     r = randi([21 30],1);
    % %     sample = [ sample; db{ r } ];
    %     sample = [ sample; db{ i } ];
    % end

    class = knnclassify(sample, training, group)

