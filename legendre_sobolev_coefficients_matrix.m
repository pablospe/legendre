function M = legendre_sobolev_coefficients_matrix(dim)
    legendre_sobolev_matrix;  % load LS_coeffs matrix
   
    M = LS_coeffs(1:dim,1:dim);
end