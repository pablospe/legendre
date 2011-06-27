function ret = moments_discreto(n, f, L)
%     ret = uint64(zeros(1,n));
    ret = double(zeros(1,n));
    for i = 1:n
%         ret(i) = mu(i-1, f/L, L, 1);
%         ret(i) = mu(i-1, f, L, L) / L^i;

        ret(i) = momento(i-1, f/L, L, 1);  % con version mi version
%       ret(i) = momento(i-1, f, L, 1);    % con version de JCG

    end
end