function [alpha, U, C] = aprox(n, f, L)
    U = moments(n, f, L)';  
    C = legendre_coefficients_matrix(n);
    
    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U;
    end
    
    Poli_Legendre = fliplr(C);
    
    delta = 0.001;
    
    % Plot aprox function
    t = 0:delta:1;
    plot( t*L, aprox_eval(alpha, Poli_Legendre, n, t) - aprox_eval(alpha, Poli_Legendre, n, 0) );
%     plot( t*L, aprox_eval(alpha, Poli_Legendre, n, t) );
    title( ['N = ',int2str(n)] );
    axis([0 L -1.089 1.482]);
    
    % Plot real function
    t = 0:delta:L;
    hold on;
    plot( t, f(t), 'Color', 'red' );
    hold off;
end


function ret = aprox_eval( alpha, fliplr_C, n, t )
    ret = 0;
    for k=1:n
        ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
    end          
end
