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

test_10_fold = create_test_data( methodCrossVal, db, m, degree, k, P ); 
fprintf('Time: %3.2f sec\n',toc);



%% run tests

    % minCuadrado
    
% euclidean    
tic;
% result_minCuadrados_euclidean   = run_test( test_10_fold, MethodRecog.euclidean );
fprintf('Time (euclidean): in %3.2f sec\n',toc);

% cityblock
tic;
% result_minCuadrados_cityblock   = run_test( test_10_fold, MethodRecog.cityblock );
fprintf('Time (cityblock): in %3.2f sec\n',toc);

% mahalanobis
tic;
% result_minCuadrados_mahalanobis = run_test( test_10_fold, MethodRecog.mahalanobis);
fprintf('Time (mahalanobis): in %3.2f sec\n',toc);

% libsvm
% options = '-c 512 -g 256 -e 1 -h 0 -b 0 -q';   % optimo ?
% options = '-c 128 -g 256 -e 1 -h 0 -b 0 -q';
% options = '-c 64 -g 64 -e 0.1 -h 0 -b 0 -q';
% options = '-c 896 -g 256 -e 0.1 -h 0 -b 0 -q';
% options = '-c 32768 -g 8 -b 1 -q';   

% options = '-c 128 -g 64 -e 0.1 -h 0 -b 0 -q';
% options = '-c 2^(10) -g 2^(3) -e 0.1 -h 0 -b 0 -q';

% options = '-c 2048 -g 8 -e 0.1 -h 0 -b 0 -q';
% options = '-c 256 -g 32 -e 0.1 -h 0 -b 0 -q';
% options = '-c 32 -g 32 -e 0.1 -h 0 -b 0 -q';
% options = '-c 64 -g 32 -e 0.1 -h 0 -b 0 -q';
options = '-c 128 -g 16 -e 0.1 -h 0 -b 0 -q';   % <-- optimo para test_10_fold

tic;
% result_minCuadrados_libsvm = run_test( test_10_fold, MethodRecog.libsvm, options );
fprintf('Time (libsvm): in %3.2f sec\n',toc);


% options{1}  = '-c   128 -g 128 -e 0.1 -h 0 -b 0 -q';
% options{2}  = '-c    64 -g 128 -e 0.1 -h 0 -b 0 -q';
% options{3}  = '-c  1024 -g 128 -e 0.1 -h 0 -b 0 -q';
% options{4}  = '-c    64 -g 256 -e 0.1 -h 0 -b 0 -q';
% options{5}  = '-c    64 -g 256 -e 0.1 -h 0 -b 0 -q';
% options{6}  = '-c    16 -g 256 -e 0.1 -h 0 -b 0 -q';
% options{7}  = '-c 32768 -g 0.5 -e 0.1 -h 0 -b 0 -q';
% options{8}  = '-c    32 -g 256 -e 0.1 -h 0 -b 0 -q';
% options{9}  = '-c   128 -g 128 -e 0.1 -h 0 -b 0 -q';
% options{10} = '-c  1024 -g  64 -e 0.1 -h 0 -b 0 -q';
% 
% tic;
% result_minCuadrados_libsvm = 0;
% for i=1:10
%     t{1} = test_10_fold{i};
%     result = run_test( t, MethodRecog.libsvm, options{i} );
%     result_minCuadrados_libsvm = result_minCuadrados_libsvm + result/10;
% end
% fprintf('Time (libsvm): in %3.2f sec\n',toc);



tic;
P = 0.9; % optimo ? 
% P = 0.7; 
% result_minCuadrados_minkowski = run_test( test_10_fold, MethodRecog.minkowski, P);
fprintf('Time (minkowski): in %3.2f sec\n',toc);



% HMM
tic;
options = '';
result_minCuadrados_libsvm = run_test( test_10_fold, MethodRecog.hmm, options );
fprintf('Time (libsvm): in %3.2f sec\n',toc);


    % legendre
% result_legendre_euclidean = run_test( test_L, MethodRecog.euclidean );
% result_legendre_cityblock = run_test( test_L, MethodRecog.cityblock );
% result_legendre_mahalanobis = run_test( test_L, MethodRecog.mahalanobis);



% plot tests
h = figure; 

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
% plot( result_minCuadrados_minkowski(:,1), result_minCuadrados_minkowski(:,2), ...
%        '-x', 'Color', 'red', 'MarkerFaceColor','r');     
   
  
   % legendre
% plot( result_legendre_euclidean(:,1), result_legendre_euclidean(:,2), ...
%        '-o', 'Color', 'blue', 'MarkerFaceColor','g'); 
% plot( result_legendre_cityblock(:,1), result_legendre_cityblock(:,2), ...
%       '-o', 'Color', 'cyan', 'MarkerFaceColor','g');
% plot( result_legendre_mahalanobis(:,1), result_legendre_mahalanobis(:,2), ...
%       '-o', 'Color', 'red', 'MarkerFaceColor','g');
  
  
legend('euclidean',  'cityblock', 'mahalanobis', 'libsvm' ) %, 'minkowski')
title(options);
%        'euclidean_L','cityblock_L', 'mahalanobis_L' );
set(gca,'XTick',0:1:25); grid on;
set(gca,'YTick',80:1:100);
set(gca,'ylim', [80 100]);

set(h,'units','normalized','outerposition',[0 0 1 1]);  % maximaze

hold off;



%% libsvmwrite
% t = test_data;

for i=1:10
    t = test_10_fold{i};
    libsvmwrite( ['train_', int2str(i), '.txt'] , double(t.training_class), sparse(t.training{13}) );
%     libsvmwrite( ['test_', int2str(i), '.txt'] ,  double(t.testing_class), sparse(t.testing{13}) );
%     libsvmwrite( ['db_', int2str(i), '.txt'],  double([t.training_class; t.testing_class]), sparse([t.training{13}; t.testing{13}]) );
end
