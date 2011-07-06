classdef database

properties (SetAccess = private)
      db         % db{ label, element_number } = element
      map        % map( label ) = number
      db_raw     % raw data, from the program: "unipen -> matlab"
end

   
methods
    %% Constructor
    function obj = database( db_raw )
        N = length(db_raw);

        idx = containers.Map;   % label -> number of labels
        for i=1:N
            % Current label
            current_label = db_raw{i}.label;

            % create map
            if  idx.isKey( current_label ) == 0
                idx( current_label ) = 1;
            else
                idx( current_label ) = idx( current_label ) + 1;
            end       

            % create database
            obj.db{ current_label, idx(current_label) } = db_raw{i};
        end

        obj.map = idx;
        obj.db_raw = db_raw;
    end

    %% size method
    
    % db.size()      = database size
    % db.size(label) = size of a particular label
    function ret = size( obj, label )
        
        % db.size()
        if nargin < 2
            ret = sum( cell2mat( obj.get_sizes() ));
            return;
        end
        
        % db.size(label)
        ret = obj.map(label);
    end
    
    %% get_trace
    function ret = get_trace( obj, label, idx )
       ret = obj.db{label,idx};
    end

    %% get labels
    function ret = get_labels( obj )
       ret = keys(obj.map);
    end
    
    %% get sizes
    function ret = get_sizes( obj )
       ret = values(obj.map);
    end
    
    

    %% plot
    function plot( obj, total_time, set_of_labels, n, m ) 
        if nargin < 2
            total_time = 0.25;
        end
        if nargin < 3
            set_of_labels = obj.get_labels();
        end
        if nargin < 4           
            n = 2;
        end
        if nargin < 5
            m = 5;
        end

        figure(1);
        mat_labels = cell2mat(set_of_labels);   % cell to mat
        MAX = max( cell2mat( values(obj.map, set_of_labels) ) ); % common maximum
        i = 0;
        for idx=1:MAX
            for label=mat_labels
                if( idx <= obj.size(label) ) 
                    subplot( obj, label, i, idx, total_time, n, m );
                    i = i + 1;
                    [num2cell(label),idx, i]   % display
                end
            end
        end          
    end
    
    %%
    function subplot( obj, label, pos, idx, total_time, n, m )
        subplot(n, m, mod(pos,n*m)+1 )
        x = obj.get_trace(label,idx).channel{1};
        y = obj.get_trace(label,idx).channel{2};

        x = (x-min(x))/(max(x)-min(x));
        y = (y-min(y))/(max(y)-min(y));
        
        draw_trace( x, -y+1, total_time);
    end   

    end % methods block
end % classedf