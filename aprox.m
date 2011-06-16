function [alpha, U, C] = aprox(n, x)
    L = 2*pi
    U = moments(n, x, L)';  
    C = legendre_coefficients_matrix(n);
    
    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U;
    end
    
    t = 0:0.01:L;
    plot(t, polyval( wrev(alpha), t) );
    axis([0 0.8 -1.3 1.6]);
end