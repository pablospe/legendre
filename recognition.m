function class = recognition( trace, all )   %, d, method )
    d = 12;
%     training = all.training{d};
%     group = all.training_class{d};

    trace = fe( trace, Method.least_square_L, d );

    all.testing{d} = trace.features{Method.least_square_L,d};
    
    options = '-c 512 -g 256 -e 1 -h 0 -b 0 -q';
    class = run_single_test( all, d, MethodRecog.cityblock, options );
end

