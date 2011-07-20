function curves_features = feature_extraction( x, y, m, d )
    switch(m)
        case MethodFE.moments_L      
        % Legendre
        x_alpha = aprox_discreta(d,x);
        y_alpha = aprox_discreta(d,y);

        case MethodFE.least_square_L
        % MinCuadrados
        x_alpha = aprox_minCuadrado(d,x);
        y_alpha = aprox_minCuadrado(d,y);
    end

    curves_features = [x_alpha y_alpha];
end
