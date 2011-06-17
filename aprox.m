function [alpha] = aprox(n, x)
%     a = 0;
%     b = 2*pi;
%     alpha = double(zeros(1,n));
%     for i = 1:n
%         res = 0;
%         for j = 1:n
%             res = res + legendre_coefficients(i-1,j-1) * mu(j-1,x,b) / b+1 /(2*j);
%         end
%          
%          alpha(i) = res;
%     end
%     
%     t = 0:0.001:n;
%     plot(t, polyval( wrev(alpha), t) );
% %     axis([0 0.8 -1.3 1.6]);
% end

    a = 0;
    b = 2*pi;
    U = transpose( moments(n, x, b) / 2*b+1 );
    C = legendre_coefficients_matrix(n);
    
    alpha = double(zeros(1,n));
    for i = 1:n
        alpha(i) = C(i,:) * U / 2*i+1;
    end
       
    t = 0:0.001:n;
    plot(t, x_aprox(t,alpha,C,n) );
%     axis([0 0.8 -1.3 1.6]);
end



function ret = x_aprox(x,alpha,C,n)
    ret = 0;
    for i = 1:n
        ret = ret + alpha(i)*legendre_eval(i, C, x);
    end
end
