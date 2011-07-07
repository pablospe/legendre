f = u( [0:0.0001:1] );
x = f;

% x = db.get_trace('1',27).channel{1}';


for N=7:20
    % MinCuadrados
    global C;
    C = legendre_coefficients_matrix(N);

    L = length(x);
    delta = 1/L;
    t = [0:delta:1-1/L]';    
    
    %
    subplot(121)
    [xest,alpha] = aprox_minCuadrado(N,x);
    plot_aprox( x, xest, t, 'Minimos cuadrados' );
    error_minimos_cuadrado = bestfit( x, xest )
    
    % Legendre
    subplot(122)
    [xest2,alpha2] = aprox_discreta(N,x);
    xest2 = xest2(1:end-1);
    plot_aprox( x, xest2, t, ['N = ',int2str(N)] );
    error = bestfit( x, xest2 )
        
    pause(1);
end


