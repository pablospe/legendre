function beta = logist2Fit(y,x, addOne)
% LOGIST2FIT 2 class logsitic classification
% function beta = logist2Fit(y,x, addOne)
%
% y(i) = 0/1
% x(:,i) = i'th input - we optionally append 1s to last dimension
% w(i) = optional weight
%
% beta(j)- regression coefficient

if nargin < 3, addOne = 1; end
Ncases = size(x,2);
assert(Ncases == length(y));
if addOne
  x = [x; ones(1,Ncases)];
end
beta = logist2(y(:), x');
beta = beta(:);
