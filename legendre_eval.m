function ret = legendre_eval(i, C, x)
   ret = polyval( wrev(C(i+1,:)), x); 
end
