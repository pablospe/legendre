function muk=momento(f,k,b,L)
delta=b/L;
muk=0;
for n=1:L-1
    muk=muk+( f(n)/2*(delta^(k+1))*(n-1)^k + n^k/2*(delta^(k+1))*f(n+1) );
end

% delta=1/L;
% muk=0;
% for n=1:L-1
%     muk = muk+( ((f(n)+f(n+1))/(2*(k+1)))*delta^(k+1)*(n)^k - ((f(n)+f(n+1))/(2*(k+1)))*delta^(k+1)*(n-1)^k );
% end


% delta=1/L;
% muk=0;
% for n=1:L-1
%     muk=muk+( f(n)*n^k + f(n+1)*(n+1)^k )*delta/2;
% end
