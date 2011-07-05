function plot_db( db, aprox ) 

if nargin < 2
    aprox = 0;
end

    figure(1);

    MAX = 110; % cantidad de sample por numeros
    
    db_split = split(db);
    
    for idx=1:MAX
        idx
        for i = 1:10 %[1 4 5 7]
%             if( aprox == 0 )
                subplot_db( db_split, i, idx, 0.3 );
%             else
                
%             end           
        end
    end

end

function subplot_db( db, pos, idx, total_time )
    subplot(2,5,pos)
    x = db{pos,idx}.channel{1};
    y = db{pos,idx}.channel{2};
    
    x = (x-min(x))/(max(x)-min(x));
    y = (y-min(y))/(max(y)-min(y));
    

    
%     x = x(1:end-1);
%     y = y(1:end-1);
    
    draw_trace( x, -y+1, total_time);
end



% function subplot_aprox( db, pos, idx, total_time )
% 
%     C = legendre_coefficients_matrix(n);  
%     Poli_Legendre = fliplr(C);
% 
%     L = length( db{pos,idx}.channel{1} );
%     delta = 1/L;
%     
%     % Plot aprox function
%     t = 0:delta:1;
%     alpha = db{pos,idx}.features
%     x_est = aprox_eval(alpha, Poli_Legendre, 10, t);
%     y_est = aprox_eval(alpha, Poli_Legendre, 10, t);
% %     plot( t, f_est );
% %     title( ['N = ',int2str(n)] );
% %     fmin = min(f);
% %     fmax = max(f);
% %     axis([0 1 fmin-fmin*0.01 fmax+fmax*0.01]);
% %     
% %     
% %     % Plot real function
% %     t = 0:delta:1;
% %     hold on;
% %     plot( t(1:end-1), f, 'Color', 'red' );
% %     hold off;
%     
% %     error = vpa(RMS( f, f_est ))
%     subplot(2,5,pos)
%     x = db{pos,idx}.channel{1};
%     y = db{pos,idx}.channel{2};
%     
%     x = (x-min(x))/(max(x)-min(x));
%     y = (y-min(y))/(max(y)-min(y));
%      
%     draw_trace( x, -y+1, total_time);
% end
% 
% function ret = aprox_eval( alpha, fliplr_C, n, t )
%     ret = 0;
%     for k=1:n
%         ret = ret + alpha(k) * polyval( fliplr_C(k,:), t);
%     end          
% end
