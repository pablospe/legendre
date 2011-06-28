function ret = bestfit( x, x_est )
    ret = 100*(1 - (norm(x-x_est)/norm(x-mean(x))));
%     for i = 1:length(x)-1
%         ret = ret + sqrt( abs(x(i)^2 - x_est(i)^2) );
%     end
  

end