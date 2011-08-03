function ret = moments_discreto(n, f, t)
%     ret = uint64(zeros(1,n));
    ret = double(zeros(1,n));
    for i = 1:n
        L = t(end);
        
%         ret(i) = mu(i-1, f/L, L, 1);
%         ret(i) = mu(i-1, f, L, L) / L^i;

%         ret(i) = momento(i-1, f/L, L, 1);    % con version mi version
%         ret(i) = momento(i-1, f, L, 1);      % con version de JCG
        
%         ret(i) = moment2(i-1, f, t);   % con version que usa "trapz"
        
        ret(i) = moment3(i-1, f, t) / L^i;   % con version que usa "trapz"
    end
end