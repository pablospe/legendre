%%  Method
m = Method.least_square_L;
degree=3:20;

%% Features extraction
for d=degree
    global C;
    C = legendre_coefficients_matrix(d);  
    
    disp( ['feature_extraction  -  d = ', num2str(d)] );    
    db.feature_extraction( m, d );
end

%% Whiteboard
global t;
global all;

t = trace;
all = test_data(db, m, 12, 1);

whiteboard;


%% Create "training{d}" and "testing{d}" sets - cross-validation

mat_labels = cell2mat(db.get_labels());
% mat_labels = mat_labels(mat_labels~='1');

percentaje = 0.9;   % training percentaje: 90 %    
    
result = [];
for d=degree
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
tic;
N=10;
for i=1:N
    i
    test_10{i} = test_data(db, m, degree, 0.9);
end
fprintf('Time: %3.2f sec\n',toc);

%%
% t = test_data;
t = test_10{1};
libsvmwrite('train.txt', double(t.training_class{12}), sparse(t.training{12}) );
libsvmwrite('test.txt',  double(t.testing_class{12}), sparse(t.testing{12}) );
libsvmwrite('db.txt',  double([t.training_class{12}; t.testing_class{12}]), sparse([t.training{12}; t.testing{12}]) );


%%


libsvmread('train.txt.model', model );


%% run tests

    % minCuadrado
% tic;
% result_minCuadrados_euclidean   = run_test( test_10, MethodRecog.euclidean );
% fprintf('Time (euclidean): in %3.2f sec\n',toc);
% 
% tic;
% result_minCuadrados_cityblock   = run_test( test_10, MethodRecog.cityblock );
% fprintf('Time (cityblock): in %3.2f sec\n',toc);
% 
% tic;
% result_minCuadrados_mahalanobis = run_test( test_10, MethodRecog.mahalanobis);
% fprintf('Time (mahalanobis): in %3.2f sec\n',toc);


% options = '-c 512 -g 256 -e 1 -h 0 -b 0 -q';   % optimo ?
% options = '-c 128 -g 256 -e 1 -h 0 -b 0 -q';
% options = '-c 64 -g 64 -e 0.1 -h 0 -b 0 -q';
% options = '-c 896 -g 256 -e 0.01 -h 0 -b 1 -q';
options = '-c 32768 -g 8 -b 1 -q';   
tic;
result_minCuadrados_libsvm = run_test( test_10, MethodRecog.libsvm, options );
fprintf('Time (libsvm): in %3.2f sec\n',toc);
 

    % legendre
% result_legendre_euclidean = run_test( test_L, MethodRecog.euclidean );
% result_legendre_cityblock = run_test( test_L, MethodRecog.cityblock );
% result_legendre_mahalanobis = run_test( test_L, MethodRecog.mahalanobis);



% plot tests
figure;

   % minCuadrado
plot( result_minCuadrados_euclidean(:,1), result_minCuadrados_euclidean(:,2), ...
       '-o', 'Color', 'blue', 'MarkerFaceColor','b'); 
hold on;      
plot( result_minCuadrados_cityblock(:,1), result_minCuadrados_cityblock(:,2), ...
      '-o', 'Color', 'cyan', 'MarkerFaceColor','b');
plot( result_minCuadrados_mahalanobis(:,1), result_minCuadrados_mahalanobis(:,2), ...
      '-o', 'Color', 'red', 'MarkerFaceColor','b');
plot( result_minCuadrados_libsvm(:,1), result_minCuadrados_libsvm(:,2), ...
       '-x', 'Color', 'green', 'MarkerFaceColor','r');  
  
  
   % legendre
% plot( result_legendre_euclidean(:,1), result_legendre_euclidean(:,2), ...
%        '-o', 'Color', 'blue', 'MarkerFaceColor','g'); 
% plot( result_legendre_cityblock(:,1), result_legendre_cityblock(:,2), ...
%       '-o', 'Color', 'cyan', 'MarkerFaceColor','g');
% plot( result_legendre_mahalanobis(:,1), result_legendre_mahalanobis(:,2), ...
%       '-o', 'Color', 'red', 'MarkerFaceColor','g');
  
  
legend('euclidean',  'cityblock',   'mahalanobis', 'libsvm')
title(options);
%        'euclidean_L','cityblock_L', 'mahalanobis_L' );
set(gca,'XTick',0:1:25); grid on;

hold off;


%%
