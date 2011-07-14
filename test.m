%%  Method
m = Method.least_square_L;

%% Features extraction
for d=3:25
    global C;
    C = legendre_coefficients_matrix(d);  
    
    disp( ['feature_extraction  -  d = ', num2str(d)] );    
    db.feature_extraction( m, d );
end

%% Create "training{d}" and "testing{d}" sets - cross-validation

mat_labels = cell2mat(db.get_labels());
% mat_labels = mat_labels(mat_labels~='1');

percentaje = 0.9;   % training percentaje: 90 %    
    
result = [];
for d=3:20
    training = [];
    training_class = [];
    testing = [];
    testing_class = [];
    
    for label=mat_labels
        N = db.size(label);
%         r = randperm(N);

        % r == [training_domain testing_domain]
        training_domain = r(1:N*percentaje);
        testing_domain  = r(N*percentaje+1:end);

        % training
        for i=training_domain     
            training = [ training; db.get_trace(label,i).features{m,d} ];
            training_class = [ training_class; label ];
        end

        % testing
        for i=testing_domain
            testing = [ testing; db.get_trace(label,i).features{m,d} ];
            testing_class = [ testing_class; label ];
        end       
    end
    
%     class = knnclassify(testing, training, training_class, 1, 'cityblock' );
    class = knnclassify(testing, training, training_class, 1, 'euclidean' );
%     class = classify(testing, training, training_class, 'mahalanobis' );
%     class = mahalanobis(testing, training, training_class );
    recognition = 100 * sum(class == testing_class) / length(class);
    [d recognition]
    result = [ result; [d recognition]];        
end

plot( result(:,1), result(:,2), ...
      '-o', 'Color', 'blue', 'MarkerFaceColor','b'); 
  
  
%% create test_data
t1 = cputime;
N=100;
for i=1:N
    i
    test{i} = test_data(db, m, 3:25, 0.9);
end
t1 = cputime-t1



%%
for i=1:10
    test_10{i} = test{i};
end

%% run tests

result_minCuadrados_euclidean   = run_test( test_10, MethodRecog.euclidean );
a=1
result_minCuadrados_cityblock   = run_test( test_10, MethodRecog.cityblock );
a=2
result_minCuadrados_mahalanobis = run_test( test_10, MethodRecog.mahalanobis);
a=3

% result_legendre_euclidean = run_test( test_L, MethodRecog.euclidean );
% result_legendre_cityblock = run_test( test_L, MethodRecog.cityblock );
% result_legendre_mahalanobis = run_test( test_L, MethodRecog.mahalanobis);



%% plot tests
figure;

   % minCuadrado
plot( result_minCuadrados_euclidean(:,1), result_minCuadrados_euclidean(:,2), ...
       '-o', 'Color', 'blue', 'MarkerFaceColor','b'); 
hold on;      
plot( result_minCuadrados_cityblock(:,1), result_minCuadrados_cityblock(:,2), ...
      '-o', 'Color', 'cyan', 'MarkerFaceColor','b');
plot( result_minCuadrados_mahalanobis(:,1), result_minCuadrados_mahalanobis(:,2), ...
      '-o', 'Color', 'red', 'MarkerFaceColor','b');

%    % legendre
% plot( result_legendre_euclidean(:,1), result_legendre_euclidean(:,2), ...
%        '-o', 'Color', 'blue', 'MarkerFaceColor','g'); 
% plot( result_legendre_cityblock(:,1), result_legendre_cityblock(:,2), ...
%       '-o', 'Color', 'cyan', 'MarkerFaceColor','g');
% plot( result_legendre_mahalanobis(:,1), result_legendre_mahalanobis(:,2), ...
%       '-o', 'Color', 'red', 'MarkerFaceColor','g');
  
  
legend('euclidean',  'cityblock',   'mahalanobis')
%        'euclidean_L','cityblock_L', 'mahalanobis_L' );
hold off;


%%


