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

        case MethodFE.moments_L_arc
            s = arc_length(x,y);
            domain = s/s(end);
            x_alpha = aprox_discreta(d,x,domain);
            y_alpha = aprox_discreta(d,y,domain);        
        
        case MethodFE.least_square_L_arc
            s = arc_length(x,y);
            domain = s/s(end);
            x_alpha = aprox_minCuadrado(d,x,domain);
            y_alpha = aprox_minCuadrado(d,y,domain);
        
    end

    curves_features = [x_alpha y_alpha];
end
