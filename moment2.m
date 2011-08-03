function m = moment2(k, x, t)
%Computes the kth moment mean of a function
%
%	m = moment(t, x, k)
%
%		m	= kth moment of x
%		t	= domain
%		x	= data
%		k	= kth moment
%
%	m = int(t^k * x)
%
%	where int is integral over all t
%	integral is calculated using trapezium rule


if ~exist('t', 'var')
    L = length(x);
    t = [0:L-1]/L;
else
    t = t';
end


% mom = sum(ti^k * xi * dti)
%	i  = pixel number
%	dt = pixel width
p = ((t.^k).*ones(1, length(x))).*x;
m = trapz(t, p);