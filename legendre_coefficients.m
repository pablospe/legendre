function ret = legendre_coefficients(i,j)
    if j <= i
    	ret = (2*i+1)^(1/2)*(-1)^(j) * nchoosek(i,j) * nchoosek(i+j,j);
    else
        ret = 0;
    end    
end