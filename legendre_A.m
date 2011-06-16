function A = legendre_A(dim)
    A = zeros(dim);
    
    for i=1:dim,
        for j=1:dim,
            if( j <= i )
%                 A(i,j) = legendre_coefficients(i-1,j-1);
                A(i,j) = apply( @legendre_coefficients, i-1, j-1);
            end
        end
    end
    
    return
end

function ret = legendre_coefficients(i,j)
	ret = (-1)^(i+j) * nchoosek(i,j) * nchoosek(i+j,j);
end


function ret = apply(f,i,j)
	ret = f(i,j);
end


