

%%
i=1;
x = db2{i}.channel{1};
y = db2{i}.channel{2};
curves_features = feature_extraction( x, y, 10 );


%%
d = 16;
num = 9;
C = legendre_coefficients_matrix(d);
db_training1 = feature_extraction_db( db_training1, d );
db_testing = feature_extraction_db( db_testing, d );
db_splited_training1 = split(db_training1);
db_splited_testing = split(db_testing);


% N = length(db_splited);
N = 110;

training = [];
group = [];
for label=1:10
    for i=1:N
        training = [ training; db_splited_training1{label,i}.features ];
        group = [ group; mod(label,10) ];
    end
end

%     group = [[1:10], [1:10]];

sample = [];
for i=1:N
    sample = [ sample; db_splited_testing{num,i}.features ];
end

% for i=21:30
%     r = randi([21 30],1);
% %     sample = [ sample; db{ r } ];
%     sample = [ sample; db{ i } ];
% end

class = knnclassify(sample, training, group);

s = [d,num,length(class(class==num))/length(class)]
