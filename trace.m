classdef trace
    properties
        channel   % channel. i.e. [ [x1 x2 .. xn], [y1 y2 ... yn] ]
        label     % Ground truth
        dim       % i.e [800,600]
        features  % features{method(m),d} = curves_features, [x_alpha y_alpha]
    end
   
    methods       
        % m: method
        % d: degree
        function obj = fe( obj, m, d )
            obj.features{m,d} = feature_extraction( obj.channel{1}, ...
                                                    obj.channel{2}, ...
                                                    d );           
       end
    end
end