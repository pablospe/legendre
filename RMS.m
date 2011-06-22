function ret = RMS( x, x_est )
    ret = 0;
    for i = 1:length(x)-1
        ret = ret + sqrt( abs(x(i)^2 - x_est(i)^2) );
    end

end