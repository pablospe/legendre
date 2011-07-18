function result = run_test( test_data, method, options )
    if nargin < 3
        options = '';
    end

    N = length(test_data);  
    result = [];
    for i=1:N  % for_all test_data
        t = test_data{i};
        current_result = [];
        for d=t.degree % for_all degrees
            class = run_single_test( t, d, method, options );
            recognition = 100 * sum(class == t.testing_class{d}) / length(class);
            
            current_result = [ current_result; [d recognition]];
        end
        
        if isempty(result)
            result = current_result./N;
        else
            result = result + current_result./N;
        end
    end
end
