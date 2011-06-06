function A = legendre_A(dim)
    A = zeros(dim);
    
    for i=1:dim,
        for j=1:dim,
            if( j <= i )
                A(i,j) = legendre_coefficients(i-1,j-1);
            end
        end
    end
    
    return
end