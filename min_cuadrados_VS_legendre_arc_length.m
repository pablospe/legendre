% database
x = db.trace{1}.channel{1};  % zero sample
y = db.trace{1}.channel{2};

x = (x-min(x))/(max(x)-min(x));
y = (y-min(y))/(max(y)-min(y));

% x = (x)/(max(x)-min(x));
% y = (y)/(max(y)-min(y));

% Arc-length calculation (domain)
s = arc_length(x,y);

n = length(x);
L = s(n);

subplot(221)
    plot(1:n,x);
    title('x(t)');
subplot(223)
    plot(s,x);
    title('x(s)');
subplot(222)
    plot(1:n,y);
    title('y(t)');
subplot(224)
    plot(s,y);
    title('y(s)');

% v=1; a = [max(find(s<=v)), min(find(s>=v))]    
    
%% 
   
for N=10  %*ones(1,1000)

    C = legendre_coefficients_matrix(N);  
    
    % MinCuadrados
    subplot(121)
    domain = s/s(end);
    [alpha, xest] = aprox_minCuadrado(N, x, domain);
    plot_aprox( x, xest, 'Minimos cuadrados', domain );
    error_minimos_cuadrado = bestfit( x, xest )
    
%     alpha
    
    % Legendre
    subplot(122)
%     domain = s;  % Se puede calcular así
    [alpha2, xest2] = aprox_discreta(N, x, domain);
    xest2 = xest2(1:end-1);
    plot_aprox( x, xest2, ['N = ',int2str(N)] );
    error_legendre = bestfit( x, xest2 )
    
%     alpha2
    
%     [error_minimos_cuadrado, error_legendre]

%     pause(0.35);
end
