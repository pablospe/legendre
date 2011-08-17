%% Start from raw data
% tic;
% db = database(db_training1_raw);
% fprintf('Time: %3.2f sec\n',toc);

clear;
load db;


%%  Method
m = MethodFE.least_square_C
normalize = false;
standardize = false;
degree=3:20;

%% Features extraction
tic;
global C;
global LS_coeffs;
global Chebyshev_coeffs;

for d=degree    
    C = legendre_coefficients_matrix(d);
    LS_coeffs = legendre_sobolev_coefficients_matrix(d);
    Chebyshev_coeffs = chebyshev_coefficients_matrix(d);
    
    disp( ['feature_extraction  -  d = ', num2str(d)] );
    db.feature_extraction( m, d, normalize, standardize );
end
fprintf('Time: %3.2f sec\n',toc);

%% Whiteboard

% whiteboard(db);
 
  
%% create test_data (Cross-Validation data)

tic;
k = 10;             % k: number of test_data (for HoldOut)
                    % k: number of folds (for Kfold)
P = 0.9;            % P=0.9  ==>  training: 90% -- test: 10%                    
                    
% methodCrossVal = MethodCrossVal.HoldOut;
methodCrossVal = MethodCrossVal.Kfold;

% [test_10_fold, indices] = create_test_data( methodCrossVal, db, m, degree, k, P );

test_10_fold = create_test_data_Kfold( db, m, degree, k, indices );

fprintf('Time (Cross-Validation): %3.2f sec\n',toc);



%% run tests
   
% euclidean    
tic;
result_euclidean   = run_test( test_10_fold, MethodRecog.euclidean );
fprintf('Time (euclidean): in %3.2f sec\n',toc);

% cityblock
tic;
result_cityblock   = run_test( test_10_fold, MethodRecog.cityblock );
fprintf('Time (cityblock): in %3.2f sec\n',toc);

% mahalanobis
tic;
result_mahalanobis = run_test( test_10_fold, MethodRecog.mahalanobis);
fprintf('Time (mahalanobis): in %3.2f sec\n',toc);

% libsvm\pi
% options  = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
% options  = '-t 0 -c 32 -g 0.0078125 -e 0.1 -h 0 -b 0 -q';

if normalize == true
    options{MethodFE.moments_L}           = '-c 32 -g 0.5 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.moments_L_arc}       = '-c 8 -g 8 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_L}      = '-c 8 -g 2 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_L_arc}  = '-c 8 -g 8 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_LS}     = '-c 2 -g 2 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_LS_arc} = '-c 2 -g 2 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_C}      = '-c 8 -g 2 -e 0.1 -h 0 -b 0 -q'; 
    options{MethodFE.moments}             = '-c 32768 -g 0.5 -e 0.1 -h 0 -b 0 -q';
else
    options{MethodFE.moments_L}           = '-c 2048 -g 8 -e 0.1 -h 0 -b 0 -q'; 
    options{MethodFE.moments_L_arc}       = '-c 32768 -g 8 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_L}      = '-c 32768 -g 2 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_L_arc}  = '-c 32768 -g 2 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.least_square_LS}     = '-c 2048 -g 8 -e 0.1 -h 0 -b 0 -q'; 
    options{MethodFE.least_square_LS_arc} = '-c 2048 -g 2 -e 0.1 -h 0 -b 0 -q'; 
    options{MethodFE.least_square_C}      = '-c 32768 -g 2 -e 0.1 -h 0 -b 0 -q';
    options{MethodFE.moments}             = '-c 32768 -g 8 -e 0.1 -h 0 -b 0 -q';
end
    
% MethodFE.moments_L
% MethodFE.moments_L_arc
% MethodFE.least_square_L
% MethodFE.least_square_L_arc
% MethodFE.least_square_LS
% MethodFE.least_square_LS_arc
% MethodFE.least_square_C
% MethodFE.moments


tic;
result_libsvm = run_test( test_10_fold, MethodRecog.libsvm, options{m} );
fprintf('Time (libsvm): in %3.2f sec\n',toc);



tic;
P = 0.9; % optimo ? 
% P = 0.7; 
% result_minkowski = run_test( test_10_fold, MethodRecog.minkowski, P);
fprintf('Time (minkowski): in %3.2f sec\n',toc);



% HMM
tic;
% options = '';
% result_hmm = run_test( test_10_fold, MethodRecog.hmm, options );
fprintf('Time (hmm): in %3.2f sec\n',toc);


    % legendre
% result_legendre_euclidean = run_test( test_L, MethodRecog.euclidean );
% result_legendre_cityblock = run_test( test_L, MethodRecog.cityblock );
% result_legendre_mahalanobis = run_test( test_L, MethodRecog.mahalanobis);


%% 

X = [];
X = [X result_euclidean(:,1)];
X = [X result_cityblock(:,1)];
X = [X result_mahalanobis(:,1)];
X = [X result_libsvm(:,1)];

Y = [];
Y = [Y result_euclidean(:,2)];
Y = [Y result_cityblock(:,2)];
Y = [Y result_mahalanobis(:,2)];
Y = [Y result_libsvm(:,2)];

[h,axes] = createfigure(X,Y);

% Create title
title({ [ m.get_description(), ' - Preprocessed: ', num2str(normalize) ] ; ...
        ['libsvn options = ', options{m}] } );

% Legend position
legend1 = legend(axes,'show');
set( legend1 ,...
     'Position',[0.689525566487775 0.130122216664188 0.199519230769231 0.268962848297214]);

    
% Maximaze
set(h,'units','normalized','outerposition',[0 0 1 1]);


%%
% Expand axes to fill figure
T = get(axes,'tightinset'); 
set(axes,'position',[T(1) T(2) 1-T(1)-T(3) 1-T(2)-T(4)]);

legend1 = legend(axes,'show');
set( legend1 , 'Position',[0.775 0.13 0.19 0.26]);


save2pdf( [m.get_string_name(), '_preproceso_', num2str(normalize), '.pdf'], gcf, 300);


%% libsvmwrite
% t = test_data;

% for i=1:10
%     t = test_10_fold{i};
%     libsvmwrite( ['train_', int2str(i), '.txt'] , double(t.training_class), sparse(t.training{13}) );
%     libsvmwrite( ['test_', int2str(i), '.txt'] ,  double(t.testing_class), sparse(t.testing{13}) );
%     libsvmwrite( ['db_', int2str(i), '.txt'],  double([t.training_class; t.testing_class]), sparse([t.training{13}; t.testing{13}]) );
% end

t = test_10_fold{1};
libsvmwrite( [m.get_string_name(), '_preproceso_', num2str(normalize), '.txt'],  double([t.training_class; t.testing_class]), ...
                                     sparse([t.training{10}; t.testing{10}]) );
                                 
                             
