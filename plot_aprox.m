function plot_aprox( f, f_aprox, t, str_title )
%     figure(1)
    plot( t, f_aprox, 'Color', 'green' );
    title( str_title );
    fmin = min(f);
    fmax = max(f);
    axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
    hold on;
    plot( t, f, 'Color', 'red');
    hold off;
end
