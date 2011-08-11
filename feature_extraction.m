function curves_features = feature_extraction( x, y, m, d )
global C;
global LS_coeffs;
global Chebyshev_coeffs;
            
    switch(m)
        
        % Moments
        case MethodFE.moments_L      
        x_alpha = aprox_discrete(d,x,C);
        y_alpha = aprox_discrete(d,y,C);

        case MethodFE.moments_L_arc
            s = arc_length(x,y);
            domain = s/s(end);
            x_alpha = aprox_discrete(d,x,domain);
            y_alpha = aprox_discrete(d,y,domain);        

            
        % LeastSquares            
        case MethodFE.least_square_L
        x_alpha = aprox_least_squares(d,x,C);
        y_alpha = aprox_least_squares(d,y,C);
            
        case MethodFE.least_square_L_arc
            s = arc_length(x,y);
            domain = s/s(end);
            x_alpha = aprox_least_squares(d,x,C,domain);
            y_alpha = aprox_least_squares(d,y,C,domain);

        case MethodFE.least_square_LS
            x_alpha = aprox_least_squares(d,x,LS_coeffs);
            y_alpha = aprox_least_squares(d,y,LS_coeffs);
            
        case MethodFE.least_square_LS_arc
            s = arc_length(x,y);
            domain = s/s(end);
            x_alpha = aprox_least_squares(d,x,LS_coeffs,domain);
            y_alpha = aprox_least_squares(d,y,LS_coeffs,domain);
            
        case MethodFE.least_square_C
            L = length(x);
            delta = 1/L;
            domain = [-1:delta*2:1-1/L];   % [-1,1]
            x_alpha = aprox_least_squares(d,x,Chebyshev_coeffs,domain);
            y_alpha = aprox_least_squares(d,y,Chebyshev_coeffs,domain);
            
        case MethodFE.moments
            L = length(x);
            delta = 1/L;
            t = [0:delta:1-1/L];
            
            x_alpha = moments_discrete(d, x, t);           
            y_alpha = moments_discrete(d, y, t);
            
            x_alpha = x_alpha/norm(x_alpha);
            y_alpha = y_alpha/norm(y_alpha);
                        
        
    end

    curves_features = [x_alpha y_alpha];
end
