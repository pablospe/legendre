function f_est = aprox_discreta(n, f)
    [U,delta] = moments_discreto(n, f);  
    C = legendre_coefficients_matrix(n);
    U=U';
    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U;
    end
    
    Poli_Legendre = fliplr(C);
    
    %delta = 0.001;
    
    figure(1);
    % Plot aprox function
    t = 0:delta:1;
    f_est = aprox_eval(alpha, Poli_Legendre, n, t);
%     plot( t, f_est - f_est(1) );
%     title( ['N = ',int2str(n)] );
%     f=f_est;
%     fmin = min(f);
%     fmax = max(f);
%     axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
    
    
    % Plot real function
%     t = 0:delta:1;
%     hold on;
%     plot( t(1:end-1), f, 'Color', 'red' );
%     hold off;
%     
%     RMS1 = vpa(RMS( f, f_est ))
%     RMS2 = vpa(RMS( f, f_est - f_est(1) ))
    f_est = f_est - f_est(1);
end


function ret = aprox_eval( alpha, fliplr_C, n, t )
    ret = 0;
    for k=1:n
        ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
    end          
end
