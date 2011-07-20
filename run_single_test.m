function class = run_single_test( t, d, method, options )
    if nargin < 4
        options = '';
    end

    class = single_test( t.testing{d}, t.training{d}, t.training_class, method, options, t.testing_class );
end