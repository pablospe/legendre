function ret = moments_discreto(n, x)
%     ret = uint64(zeros(1,n));
    ret = double(zeros(1,n));
    for i = 1:n
        ret(i) = momento(x,i-1);
    end    
end