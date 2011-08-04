classdef trace < handle
    properties
        channel      % channel. i.e. [ [x1 x2 .. xn], [y1 y2 ... yn] ]
        label        % Ground truth
        dim          % i.e [800,600]
        normalized   % {true, false}
    end
   
    methods
        %% Constructor
        function obj = trace( x, y )
            if nargin < 1
                return;
            end
            
            obj.channel{1} = x;
            obj.channel{2} = y;
            obj.normalized = false;
        end
        
        %% Normalization
        function obj = normalize( obj )
            if( isempty(obj.normalized) )
                obj.normalized = false;
            end
            
            if( obj.normalized == false )
                x = obj.channel{1};
                y = obj.channel{2};

                obj.channel{1} = (x-min(x))/(max(x)-min(x));
                obj.channel{2} = (y-min(y))/(max(y)-min(y));

                obj.normalized = true;
            end
        end
        
        %% Feature Extraction
        % m: method
        % d: degree
        function curves_features = feature_extraction( obj, m, d, normalize )            
            if ~exist('normalize', 'var')
                normalize = false;
            end
            
            if( normalize == true )
                obj.normalize();
            end
            
            curves_features = feature_extraction( obj.channel{1}, ...
                                                  obj.channel{2}, ...
                                                  m, d );
        end
    end
end
