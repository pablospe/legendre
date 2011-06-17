function ret = mu(k, f, L)
    ret = 0;
    delta = 0.001;
    for i = 1:delta:L-1
        a = 1;
        b = i+delta;
        ret = ret + (f(a)*a^k + 4*f((a+b)/2)*((a+b)/2)^k + f(b)*b^k) * (b - a)/6;
    end


%     ret = 0;
%     for i = 1:0.0001:L-1
%         ret = ret + (f(i+1) + f(i))/2 * ((i+1)^(k+1) - (i)^(k+1))/(k+1);
%     end

%     ret = (f(L-1) + f(L)) * L^(k+1);
%     for i = 2:L-1
%         ret = ret + (f(i-1) - f(i+1)) * (i)^(k+1);
%     end
%     ret = ret/(2*(k+1));
end