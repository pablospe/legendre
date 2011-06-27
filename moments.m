function ret = moments(n, x, L)
%     ret = uint64(zeros(1,n));
    ret = double(zeros(1,n));
    for i = 1:n
        ret(i) = mu(i-1, x, L, 1) / L^(i+1);
    end    
end