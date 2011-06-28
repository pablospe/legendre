f = u( [0:0.0001:1] )';
x = f;

for N=7:25
    
    % MinCuadrados
    Poli_Legendre = fliplr(legendre_coefficients_matrix(N));
    xx=[0:1/length(x):1-1/length(x)]';
    Lx=[];

    for k=1:N
        Lx=[Lx,polyval(Poli_Legendre(k,:),xx)];
    end
    Lambdax=Lx\x;
    xest=Lx*Lambdax;

    figure(1)
    subplot(121)
    plot( xx, xest, 'Color', 'green' );
    title( ['Minimos cuadrados'] );
    fmin = min(x);
    fmax = max(x);
    axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
    hold on;
    plot( xx, x, 'Color', 'red');
    hold off;

    error_minimos_cuadrado = bestfit( x, xest )

    
    % Legendre
    subplot(122)
    xest2 = aprox_discreta(N,x);
    xest2 = xest2(1:end-1);
    plot(xx, xest2)
    title( ['N = ',int2str(N)] );
    axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
    hold on;
    plot( xx, x, 'Color', 'red');
    hold off;
    
    error = bestfit( x, xest2' )
        
    pause;
end


