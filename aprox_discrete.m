function [alpha,f_est] = aprox_discrete(n, f, C, t)
%     global C;
    
    L = length(f);
    delta = 1/L;

    if ~exist('t', 'var')
        t = [0:delta:1-1/L];
    else
        t=t;
    end
    
    U = moments_discrete(n, f, t)';
    
    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U;
    end   
      
    if nargout > 1
        Poli_Legendre = fliplr(C);
        t = 0:delta:1;
        f_est = aprox_eval(alpha, Poli_Legendre, n, t);
    end     
    
    % Normalization
    alpha = alpha/norm(alpha);
end


function ret = aprox_eval( alpha, fliplr_C, n, t )
    ret = 0;
    for k=1:n
        ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
    end          
end
