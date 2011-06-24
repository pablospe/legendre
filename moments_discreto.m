function ret = moments_discreto(n, f, b, L)
%     ret = uint64(zeros(1,n));
    ret = double(zeros(1,n));
    for i = 1:n
        ret(i) = momento(f, i-1, b, L) / b^(n+1);
    end    
end