function plot_aprox( f, f_aprox, str_title, t )

if ~exist('t', 'var')
    L = length(f);
    delta = 1/L;
    t = 0:delta:1-1/L;   
end
    
    plot( t, f_aprox, 'Color', 'green' );
    title( str_title );
    fmin = min(f);
    fmax = max(f);
    axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
    hold on;
    plot( t, f, 'Color', 'red');
    hold off;
end
