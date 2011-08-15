%% Start from raw data
% tic;
% db = database(db_raw);
% fprintf('Time: %3.2f sec\n',toc);

%%  Method
m = MethodFE.moments_L_arc
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
    normalize = false;
    standardize = false;
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
% result_euclidean   = run_test( test_10_fold, MethodRecog.euclidean );
fprintf('Time (euclidean): in %3.2f sec\n',toc);

% cityblock
tic;
% result_cityblock   = run_test( test_10_fold, MethodRecog.cityblock );
fprintf('Time (cityblock): in %3.2f sec\n',toc);

% mahalanobis
tic;
% result_mahalanobis = run_test( test_10_fold, MethodRecog.mahalanobis);
fprintf('Time (mahalanobis): in %3.2f sec\n',toc);

% libsvm\pi
% options  = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
% options  = '-t 0 -c 32 -g 0.0078125 -e 0.1 -h 0 -b 0 -q';

options{MethodFE.moments_L}           = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
options{MethodFE.moments_L_arc}       = '-c 2048 -g 8 -e 0.1 -h 0 -b 0 -q';
options{MethodFE.least_square_L}      = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
options{MethodFE.least_square_L_arc}  = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
options{MethodFE.least_square_LS}     = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
options{MethodFE.least_square_LS_arc} = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
options{MethodFE.least_square_C}      = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';
options{MethodFE.moments}             = '-c 12 -g 2 -e 0.1 -h 0 -b 0 -q';

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
title({ m.get_description() ; ...
        ['libsvn options = ', options{m}] } );

% Legend position
legend1 = legend(axes,'show');
set( legend1 ,...
     'Position',[0.689525566487775 0.130122216664188 0.199519230769231 0.268962848297214]);

    
% Maximaze
set(h,'units','normalized','outerposition',[0 0 1 1]);


%%
% Expand axes to fill figure
% T = get(axes,'tightinset'); 
% set(axes,'position',[T(1) T(2) 1-T(1)-T(3) 1-T(2)-T(4)]);

save2pdf( [m.get_string_name(), '.pdf'], gcf, 300);


    
%%
% % plot tests
% h = figure; 
% 
%    % LeastSquares
% p = plot( result_euclidean(:,1), result_euclidean(:,2), ...
%       'MarkerFaceColor',[0.0431372560560703 0.517647087574005 0.780392169952393],...
%       'MarkerSize',11,...
%       'Marker','o',...
%       'MarkerEdgeColor',[0.972549021244049 0.972549021244049 0.972549021244049],...
%       'LineWidth',3, ...
%       'DisplayName','euclidean');
%  
% hold on;      
% plot( result_cityblock(:,1), result_cityblock(:,2), ...
%       '-o', 'Color', 'cyan', 'MarkerFaceColor','b');
% plot( result_mahalanobis(:,1), result_mahalanobis(:,2), ...
%     'MarkerFaceColor',[1 0.600000023841858 0.7843137383461],...
%     'LineWidth',3, ...
%     'MarkerSize',12,...
%     'Marker','v',...
%     'Color',[0.847058832645416 0.160784319043159 0],...
%     'DisplayName','mahalanobis');
% 
% plot( result_libsvm(:,1), result_libsvm(:,2), ...
%        '-x', 'Color', 'green', 'MarkerFaceColor','r');  
% % plot( result_hmm(:,1), result_hmm(:,2), ...
% %        '-x', 'Color', 'red', 'MarkerFaceColor','r');     
%    
%   
%    % legendre
% % plot( result_legendre_euclidean(:,1), result_legendre_euclidean(:,2), ...
% %        '-o', 'Color', 'blue', 'MarkerFaceColor','g'); 
% % plot( result_legendre_cityblock(:,1), result_legendre_cityblock(:,2), ...
% %       '-o', 'Color', 'cyan', 'MarkerFaceColor','g');
% % plot( result_legendre_mahalanobis(:,1), result_legendre_mahalanobis(:,2), ...
% %       '-o', 'Color', 'red', 'MarkerFaceColor','g');
%   
% 
% 
% 
% % ['N = ',int2str(N)]
% title({ 'First line'; ...
%         ['libsvn options = ',options] } );
% 
% % Create xlabel
% xlabel('3 \leq degree \leq 20','FontSize',13,'FontName','Droid Sans');
% 
% % Create ylabel
% ylabel('Reconocimiento (%)','FontSize',13,'FontName','Droid Sans');
% 
% 
% legend1 = legend('euclidean',  'cityblock', 'mahalanobis', 'libsvm' ) %, 'hmm' ) %, 'minkowski')
% %        'euclidean_L','cityblock_L', 'mahalanobis_L' );
% 
% set(legend1,...
%     'TextColor',[0.423529416322708 0.250980406999588 0.39215686917305],...
%     'EdgeColor',[0.0431372560560703 0.517647087574005 0.780392169952393],...
%     'YColor',[0.0431372560560703 0.517647087574005 0.780392169952393],...
%     'XColor',[0.0431372560560703 0.517647087574005 0.780392169952393],...
%     'Position',[0.776562500000001 0.127106741573034 0.111458333333333 0.192649812734082],...
%     'FontSize',14,...
%     'FontName','Droid Serif',...
%     'Color',[1 0.960784316062927 0.901960790157318]);
% 
% set(gca,'XTick', 4:1:20); grid on;
% set(gca,'YTick', 81:1:100);
% set(gca,'ylim', [80 100]);
% set(gca,'xlim', [3 20]);
% 
% % axes1 = axes('Parent',figure1,...
% %     'YTick',[81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100],...
% %     'XTick',[4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]);
% 
% 
% 
% hold off;



%% libsvmwrite
% t = test_data;

% for i=1:10
%     t = test_10_fold{i};
%     libsvmwrite( ['train_', int2str(i), '.txt'] , double(t.training_class), sparse(t.training{13}) );
%     libsvmwrite( ['test_', int2str(i), '.txt'] ,  double(t.testing_class), sparse(t.testing{13}) );
%     libsvmwrite( ['db_', int2str(i), '.txt'],  double([t.training_class; t.testing_class]), sparse([t.training{13}; t.testing{13}]) );
% end

t = test_10_fold{1};
libsvmwrite( [m.get_string_name(), '.txt'],  double([t.training_class; t.testing_class]), ...
                                     sparse([t.training{10}; t.testing{10}]) );
                                 
                             
