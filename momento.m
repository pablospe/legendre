function muk=momento(k, f, L, b)

% % mi version
% muk = 0;
% delta=b/L;
% for i = 1:L-1
%     muk = muk + ( f(i)*((i-1)*delta)^k + f(i+1)*(i*delta)^k )/2;
% end



% JCG
delta=b/L;
muk=0;
for n=1:L-1
    muk=muk+( f(n)/2*((n-1)*delta)^k*delta + (n*delta)^k/2*delta*f(n+1) );
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
