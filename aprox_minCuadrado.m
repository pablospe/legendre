function [f_est,alpha] = aprox_minCuadrado(n, f)
    global C;
    
    f=f';
    L = length(f);
    delta = 1/L;
    
    Poli_Legendre = fliplr(C);

    t = [0:delta:1-1/L]';

    Lx=[];
    for k=1:n
        Lx = [ Lx, polyval(Poli_Legendre(k,:),t) ];
    end
    alpha = Lx\f;
    f_est = Lx*alpha;

    % Normalization
    alpha = alpha/norm(alpha);

    f_est = f_est';
    alpha = alpha';
end