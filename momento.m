function muk=momento(f,k,L)
delta=1/L;
muk=0;
for n=1:L-1
    muk=muk+(f(n)*(n-1)^k+f(n+1)*n^k)*(delta^(k+1))/2;
end