function ret = legendre_coefficients(i,j)
	ret = (-1)^(i+j) * nchoosek(i,j) * nchoosek(i+j,j);
end