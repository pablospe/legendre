function drawTrace( x, y, total_time )

if nargin < 3
    total_time = 1;
end

len=length(x);
for L=1:len-1
    plot(x(1:L),y(1:L));
    axis([min(x) max(x) min(y) max(y)]);
    pause( total_time/len );
end
