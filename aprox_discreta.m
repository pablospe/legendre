function [alpha,f_est] = aprox_discreta(n, f)
    global C;
    
    L = length(f);
    delta = 1/L;
    
    U = moments_discreto(n, f, L);
    U=U';
    
%     persistent C
%     if isempty(C)
%         C = legendre_coefficients_matrix(n);
%     end

    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U;
    end   
   
    % Normalization
    alpha = alpha/norm(alpha);
    
    if nargout > 1
        Poli_Legendre = fliplr(C);
        t = 0:delta:1;
        f_est = aprox_eval(alpha, Poli_Legendre, n, t);
    end     
end


function ret = aprox_eval( alpha, fliplr_C, n, t )
    ret = 0;
    for k=1:n
        ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
    end          
end
