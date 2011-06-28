f = u( [0:0.0001:1] )';
x = f;
N=10;
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

error_minimos_cuadrado = vpa(RMS( x, xest ))

subplot(122)


for n=7:25 
    xest2 = aprox_discreta(n,x);
    xest2 = xest2(1:end-1);
    plot(xx, xest2)
    title( ['N = ',int2str(n)] );
    axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
    hold on;
    plot( xx, x, 'Color', 'red');
    hold off;
    error = vpa(RMS( x, xest2 ))
    pause;
end

