function [alpha,f_est] = aprox_minCuadrado(n, f)
    global C;

    f=f';
    L = length(f);
    delta = 1/L;
    t = [0:delta:1-1/L]';
   
    Poli_Legendre = fliplr(C);
   
    Lx=[];
    for k=1:n
        Lx = [ Lx, polyval(Poli_Legendre(k,:),t) ];
    end
    alpha = Lx\f;

    % Solve least squares problem using QR.
%     [Q,R] = qr(Lx,0);
%     alpha = R\(Q'*f);    % Same as Lx\f;

    if nargout > 1
        f_est = Lx*alpha;
        f_est = f_est';
    end   

    % Normalization
    alpha = alpha/norm(alpha);         
    alpha = alpha';
end