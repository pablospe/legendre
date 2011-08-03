function m = moment3(k, f, t)

if ~exist('t', 'var')
    L = length(f);
    t = [0:L-1]/L;
end

%  Trapecio
% L=length(f);
% m=0;
% for i=2:L
%     m = m + (f(i)+f(i-1))/2 * (t(i)-t(i-1)) * ((t(i)+t(i-1))/2)^k;
% end

% Punto medio (ver pag. 5, paper "Online Stroke Modeling for Handwriting Recognition"
% L=length(f);
% m=0;
% for i=2:L
%     m = m + (f(i)+f(i-1))/2 * (t(i)^(k+1) - t(i-1)^(k+1)) / (k+1);
% end

% Mitad de calculos
L=length(f);
m=0;
for i=2:L-1
    m = m + (f(i-1)-f(i+1))/2 * (t(i)^(k+1))/ (k+1);
end
m = m + (f(L-1)+f(L))/2 * (t(L)^(k+1))/ (k+1);



