function [alpha, U, C] = aprox_discreta(n, f)
    [U,delta] = moments_discreto(n, f);  
    C = legendre_coefficients_matrix(n);
    U=U';
    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U * (2*i+1);
    end
    
    Poli_Legendre = fliplr(C);
    
    %delta = 0.001;
    
    % Plot aprox function
    t = 0:delta:1;
    plot( t, aprox_eval(alpha, Poli_Legendre, n, t) );
    title( ['N = ',int2str(n)] );
    axis([0 1 -1.5 2.5]);
    
    % Plot real function
    t = 0:delta:1;
    hold on;
    plot( t(1:end-1), f, 'Color', 'red' );
    hold off;
end


function ret = aprox_eval( alpha, fliplr_C, n, t )
    ret = 0;
    for k=1:n
        ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
    end          
end
