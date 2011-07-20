classdef trace < handle
    properties
        channel   % channel. i.e. [ [x1 x2 .. xn], [y1 y2 ... yn] ]
        label     % Ground truth
        dim       % i.e [800,600]
    end
   
    methods
       %% Constructor
        function obj = trace( x, y )
            if nargin < 1
                return;
            end
            
            obj.channel{1} = x;
            obj.channel{2} = y;
        end
        
       %% Feature Extraction
        % m: method
        % d: degree
        function curves_features = feature_extraction( obj, m, d )
            curves_features = feature_extraction( obj.channel{1}, ...
                                                  obj.channel{2}, ...
                                                  m, d );           
       end
    end
end