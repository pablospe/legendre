function [alpha, U, C] = aprox(n, x)
    L = 1;
    U = moments(n, x, L)';  
    C = legendre_coefficients_matrix(n);
    
    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U * (2*i+1);
    end
    
    Poli_Legendre = fliplr(C);
    
    delta = 0.0001;
    t = 0:delta:L;    
    
%     plot(t, aprox_eval(alpha, Poli_Legendre, n, t) - aprox_eval(alpha, Poli_Legendre, n, 0) );
    plot(t, aprox_eval(alpha, Poli_Legendre, n, t) );
    title( ['N = ',int2str(n)] );
    axis([0 0.8 -1.5 2.5]);
    hold on;
    plot(t, u(t), 'Color', 'red' );
    hold off;
end


function ret = aprox_eval( alpha, fliplr_C, n, t )
    ret = 0;
    for k=1:n
        ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
    end     
    
            
end
