classdef trace
    properties
        channel   % channel. i.e. [ [x1 x2 .. xn], [y1 y2 ... yn] ]
        label     % Ground truth
        dim       % i.e [800,600]
        features  % features{m,d} = curves_features
    end
   
    methods       
        % m: method
        % d: degree
        function obj = fe( obj, m, d )
            obj.features{m,d} = feature_extraction( obj.channel{1}, ...
                                                    obj.channel{2}, ...
                                                    m, d );           
       end
    end
end