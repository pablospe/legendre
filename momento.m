function muk=momento(f,k)
delta=1/length(f);
muk=0;
for n=1:length(f)-1
    muk=muk+(f(n)*(n-1)^k+f(n+1)*n^k)*(delta^(k+1))/2;
end