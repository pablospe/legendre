% Version continua
function ret = mu(k, f, L, b)
% discreta
% ret=0;
% delta=b/L;
% for i = 1:L-1
%     ret = ret + ( f(i)*((i-1)*delta)^k + f(i+1)*(i*delta)^k )/2;
% end

    ret = 0;
    delta = 0.001;
    for i = 0:delta:L
        a = i;
        b = a + delta;
        ret = ret + (f(b) + f(a))/2 * ((b)^(k+1) - (a)^(k+1))/(k+1);
    end

%     ret = (f(L-1) + f(L)) * L^(k+1);
%     for i = 2:L-1
%         ret = ret + (f(i-1) - f(i+1)) * (i)^(k+1);
%     end
%     ret = ret/(2*(k+1));
end