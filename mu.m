function ret = mu(k, f, L)


    ret = 0;
    for i = 1:0.0001:L-1
        ret = ret + (f(i+1) + f(i))/2 * ((i+1)^(k+1) - (i)^(k+1))/(k+1);
    end

%     ret = (f(L-1) + f(L)) * L^(k+1);
%     for i = 2:L-1
%         ret = ret + (f(i-1) - f(i+1)) * (i)^(k+1);
%     end
%     ret = ret/(2*(k+1));
end