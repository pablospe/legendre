% [train, test] = crossvalidation( N, percentaje )
%    N: observations  (size, integer)
%    P: percentaje  € (0,1)
function [train, test] = crossvalidation( N, percentaje )
        r = randperm(N);

        % r == [obj.training_domain obj.testing_domain]
        train = r(1:N*percentaje);
        test  = r(N*percentaje+1:end);    
end