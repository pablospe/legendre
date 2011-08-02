function class = hmm( testing, training, training_class, options )
    if nargin < 4
        options = '';
%     else
%         Q = options.Q;
%         M = options.M;
    end

    [gindex,groups] = grp2idx(training_class);
    ngroups = length(groups);

    for k = 1:ngroups
%         k
        train = training(gindex==k, :)';
        train = reshape(train, [1 size(train,1) size(train,2)]);
        
        model{k} =  init_model( train, 4, 3, 'full' );
        model{k} = train_model( model{k}, train );
    end    
    
    class = [];
    for i=1:length(testing)
        test = testing(i,:);
        idx = recognition( model, test );
        class = [ class; idx ];
    end

%     min( cell2
    
%     [pi, A, B, mu, Sigma] = init_mhmm( train, 2, 10, 'full' ) ;
end

%% set_values
function model = set_values(pi, A, B, mu, Sigma)
    model.pi = pi;
    model.A = A;
    model.B = B;
    model.mu = mu;
    model.Sigma = Sigma;
end

%% get_values
function [pi, A, B, mu, Sigma] = get_values(model)
    pi = model.pi;
    A = model.A;
    B = model.B;
    mu = model.mu;
    Sigma = model.Sigma;
end



%% init_model
% INPUTS:
% data{ex}(:,t) or data(:,t,ex) if all sequences have the same length
% Q = num. hidden states
% M = num. mixture components
% cov_type = 'full', 'diag' or 'spherical'
function model = init_model( data, Q, M, cov_type )
    [pi, A, B, mu, Sigma] = init_mhmm( data, Q, M, cov_type );
    model = set_values(pi, A, B, mu, Sigma);
end

%% train_model
% OPTIONS:
% 'max_iter' – número máximo de iteraciones [10] 
% 'thresh'   – umbral de convergencia [1e-4] 
% 'verbose'  – si es igual a 1, muestra en pantalla el valor de loglik en cada iteración [1]
% 'cov_type' – Tipo de matriz de covarianza: 'full', 'diag' o 'spherical' ['full']
function model = train_model( model, train )
    [pi, A, B, mu, Sigma] = get_values(model);
    [~, pi, A, mu, Sigma, B] = mhmm_em( train, pi, A, mu, Sigma, B, ...
                                        'max_iter', 10, ...
                                        'thresh', 1e-4, ...
                                        'verbose', 1, ...                                        
                                        'cov_type', 'full' );
    
    model = set_values(pi, A, B, mu, Sigma);
end

%% recognition
function idx = recognition( model, test )
    ngroups = length(model);
    for k = 1:ngroups
        [pi, A, B, mu, Sigma] = get_values(model{k});
        [loglik, ~] = mhmm_logprob(test, pi, A, mu, Sigma, B);
        logprob{k} = loglik;
    end
    [~,idx] = max(cell2mat(logprob));
end        
