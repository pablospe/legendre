%% Start from raw data
tic;
db = database(db_training1_raw);
fprintf('Time: %3.2f sec\n',toc);

%%  Method
m = MethodFE.least_square_L
degree=3:20;

%% Features extraction
tic;
global C;
for d=degree    
    C = legendre_coefficients_matrix(d);  
    
    disp( ['feature_extraction  -  d = ', num2str(d)] );    
    db.feature_extraction( m, d );
end
fprintf('Time: %3.2f sec\n',toc);

%% Whiteboard

whiteboard(db);
 
  
%% create test_data (Cross-Validation data)

tic;
k = 10;             % k: number of test_data (for HoldOut)
                    % k: number of folds (for Kfold)
P = 0.9;            % P=0.9  ==>  training: 90% -- test: 10%                    
                    
% methodCrossVal = MethodCrossVal.HoldOut;
methodCrossVal = MethodCrossVal.Kfold;

test_10 = create_test_data( methodCrossVal, db, m, degree, k, P ); 
fprintf('Time: %3.2f sec\n',toc);



%% run tests

    % minCuadrado
tic;
result_minCuadrados_euclidean   = run_test( test_10, MethodRecog.euclidean );
fprintf('Time (euclidean): in %3.2f sec\n',toc);

tic;
result_minCuadrados_cityblock   = run_test( test_10, MethodRecog.cityblock );
fprintf('Time (cityblock): in %3.2f sec\n',toc);

% tic;
result_minCuadrados_mahalanobis = run_test( test_10, MethodRecog.mahalanobis);
fprintf('Time (mahalanobis): in %3.2f sec\n',toc);

options = '-c 512 -g 256 -e 1 -h 0 -b 0 -q';   % optimo ?
% options = '-c 128 -g 256 -e 1 -h 0 -b 0 -q';
% options = '-c 64 -g 64 -e 0.1 -h 0 -b 0 -q';
% options = '-c 896 -g 256 -e 0.1 -h 0 -b 0 -q';
% options = '-c 32768 -g 8 -b 1 -q';   
tic;
result_minCuadrados_libsvm = run_test( test_10, MethodRecog.libsvm, options );
fprintf('Time (libsvm): in %3.2f sec\n',toc);

tic;
P = 0.9; % optimo ? 
% P = 0.7; 
result_minCuadrados_minkowski = run_test( test_10, MethodRecog.minkowski, P);
fprintf('Time (minkowski): in %3.2f sec\n',toc);


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
plot( result_minCuadrados_minkowski(:,1), result_minCuadrados_minkowski(:,2), ...
       '-x', 'Color', 'red', 'MarkerFaceColor','r');     
   
  
   % legendre
% plot( result_legendre_euclidean(:,1), result_legendre_euclidean(:,2), ...
%        '-o', 'Color', 'blue', 'MarkerFaceColor','g'); 
% plot( result_legendre_cityblock(:,1), result_legendre_cityblock(:,2), ...
%       '-o', 'Color', 'cyan', 'MarkerFaceColor','g');
% plot( result_legendre_mahalanobis(:,1), result_legendre_mahalanobis(:,2), ...
%       '-o', 'Color', 'red', 'MarkerFaceColor','g');
  
  
legend('euclidean',  'cityblock', 'mahalanobis', 'libsvm', 'minkowski')
title(options);
%        'euclidean_L','cityblock_L', 'mahalanobis_L' );
set(gca,'XTick',0:1:25); grid on;

hold off;



%% libsvmwrite
% % t = test_data;
% t = test_10{1};
% libsvmwrite('train.txt', double(t.training_class), sparse(t.training{12}) );
% libsvmwrite('test.txt',  double(t.testing_class), sparse(t.testing{12}) );
% libsvmwrite('db.txt',  double([t.training_class; t.testing_class]), sparse([t.training{12}; t.testing{12}]) );
% 
