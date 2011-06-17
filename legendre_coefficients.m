function ret = legendre_coefficients(i,j)
    if j <= i
    	ret = (-1)^(i+j) * nchoosek(i,j) * nchoosek(i+j,j);
    else
        ret = 0;
    end    
end