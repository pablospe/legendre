%% methods
global method;
method = containers.Map;
method('moments_L') = 1;
method('least_square_L') = 2;


%% Features extraction
for d=3:25
    global C;
    C = legendre_coefficients_matrix(d);

    db = feature_extraction_db(db, d);
end

%% cross-validation
m = 'least_square_L';
result = []
for d=3:25

    mat_labels = cell2mat(db.get_labels());
    mat_labels = mat_labels(mat_labels~='1');

    percentaje = 0.9;   % training percentaje: 90 %

    training = [];
    training_class = [];
    testing = [];
    testing_class = [];
    for label=mat_labels
        N = db.size(label);
%         r = randperm(N);

        % r = [training_domain testing_domain]
        training_domain = r(1:N*percentaje);
        testing_domain  = r(N*percentaje+1:end);

        % training
        for i=training_domain     
            training = [ training; db.get_trace(label,i).features{method(m),d} ];
            training_class = [ training_class; label ];
    %         [num2cell(label),i]
        end

        % testing
        for i=testing_domain
            testing = [ testing; db.get_trace(label,i).features{method(m),d} ];
            testing_class = [ testing_class; label ];
        end
    end


%     class = knnclassify(testing, training, training_class, 1, 'cityblock' );
    class = knnclassify(testing, training, training_class, 1, 'euclidean' );
%     class = classify(testing, training, training_class, 'mahalanobis' );
    recognition = 100 * sum(class == testing_class) / length(class);
    [d recognition]
    result = [ result; [d recognition]];
end


%%

% result_minCuadrados = result;
% result_minCuadrados_cityblock = result;
% result_minCuadrados_mahalanobis = result;


% result_legendre = result
% result_legendre_cityblock = result
% result_legendre_mahalanobis = result;


plot( result_minCuadrados(:,1), result_minCuadrados(:,2), '-o', 'MarkerFaceColor','b');
hold on;
plot( result_minCuadrados_cityblock(:,1), result_minCuadrados_cityblock(:,2), '-o', 'Color', 'cyan', 'MarkerFaceColor','b');
% hold on;
plot( result_minCuadrados_mahalanobis(:,1), result_minCuadrados_mahalanobis(:,2), '-o', 'Color', 'red', 'MarkerFaceColor','b');


% plot( result_legendre(:,1), result_legendre(:,2), '-o', 'Color', 'green', 'MarkerFaceColor','g');
% plot( result_legendre_cityblock(:,1), result_legendre_cityblock(:,2), '-o', 'Color', 'red', 'MarkerFaceColor','g');
% plot( result_legendre_mahalanobis(:,1), result_legendre_mahalanobis(:,2), '-o', 'Color', 'green', 'MarkerFaceColor','g');
hold off;


%%
x = (0: 0.1: 2.5)';
y = erf(x);
p = polyfit(x,y,6);

