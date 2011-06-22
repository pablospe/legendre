% f = u( [0:0.0001:1] )';
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

figure(2)
plot( xx, xest, 'Color', 'green' );
fmin = min(x);
fmax = max(x);
axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
hold on;
plot( xx, x, 'Color', 'red');
hold off;

vpa(RMS( x, xest ))