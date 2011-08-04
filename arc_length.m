function s = arc_length( x, y )
    n = length(x);
    s = zeros(n,1)';
    for i=2:n
        s(i) = s(i-1) + sqrt( (x(i)-x(i-1))^2 + (y(i)-y(i-1))^2 );
    end
end
