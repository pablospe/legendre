% f = u( [0:0.0001:1] );
% x = f;

% x = db.get_trace('1',27).channel{1}';


global C;

% time = [];
% t_total_1 = cputime;
% 7*ones(1,1000)
for N=7
    C = legendre_coefficients_matrix(N);

    % MinCuadrados
    L = length(x);
    delta = 1/L;
    t = [0:delta:1-1/L]';    
    
% t1 = cputime;
%     alpha = aprox_minCuadrado(N,x);
% t2 = cputime;
% time = [ time; (t2-t1) ];    
    
    subplot(121)
    [alpha, xest] = aprox_minCuadrado(N,x);
    plot_aprox( x, xest, t, 'Minimos cuadrados' );
    error_minimos_cuadrado = bestfit( x, xest )


    % Legendre
    subplot(122)
    [alpha2, xest2] = aprox_discreta(N,x);
    xest2 = xest2(1:end-1);
    plot_aprox( x, xest2, t, ['N = ',int2str(N)] );
    error_legendre = bestfit( x, xest2 )
    
%     [error_minimos_cuadrado, error_legendre]

%     pause(0.25);
end
% t_total_2 = cputime;

% [mean(time), N, t_total_2-t_total_1]

