function x = standardization( x )
    x = x';  % If A is a matrix, mean(A) treats the columns of A as vectors
    
    mn = mean(x);
    sd = std(x);
    sd(sd==0) = 1;
    
    x = bsxfun(@minus,x,mn);
    x = bsxfun(@rdivide,x,sd);
    
    x = x';
end