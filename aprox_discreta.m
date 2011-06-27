function [f_est,alpha] = aprox_discreta(n, f)
    L = length(f);
    delta = 1/L;
    
    U = moments_discreto(n, f, L);
    U=U';
    
    C = legendre_coefficients_matrix(n);

    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U;
    end
    
    Poli_Legendre = fliplr(C);
    
   
    figure(1);
    % Plot aprox function
    t = 0:delta:1;
    f_est = aprox_eval(alpha, Poli_Legendre, n, t);
    plot( t, f_est );
    title( ['N = ',int2str(n)] );
    fmin = min(f);
    fmax = max(f);
    axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
    
    
    % Plot real function
    t = 0:delta:1;
    hold on;
    plot( t(1:end-1), f, 'Color', 'red' );
    hold off;
    
    RMS1 = vpa(RMS( f, f_est ))
    
    % Normalization
    alpha = alpha/norm(alpha);
end


function ret = aprox_eval( alpha, fliplr_C, n, t )
    ret = 0;
    for k=1:n
        ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
    end          
end
