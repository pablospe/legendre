classdef database < handle

properties %(SetAccess = private)
      trace       % traces
      group       % group <-> trace  ( 1 <-> 1 relation )
      features    % feature{ trace, method, degree}      

      sizes       % sizes( label ) = number
      label2idx   % label2idx   ( '0' -> 1, '1' -> 2, ... )

      %labels     % see "labels()"
end


methods (Access = private)    
    %% Insert trace
    function obj = insert_trace( obj, trace )
        % Current label
        label = trace.label;

        % create the map 'sizes'
        if  obj.sizes.isKey( label ) == 0
            obj.sizes( label ) = 1;
        else
            obj.sizes( label ) = obj.sizes( label ) + 1;
        end       
    end
    
    %% get sizes
    function ret = get_sizes( obj )
       ret = values(obj.sizes);
    end    
end


methods 
    %% Constructor
    function obj = database( db_raw )
        N = length(db_raw);

        obj.sizes = containers.Map;       % label -> number of labels
        obj.label2idx = containers.Map;   % label -> idx
        
        % Insert trace
        for i=1:N
            obj.insert_trace( db_raw{i} );
        end

        % Create index of labels
        labels = obj.labels;
        ngroups = length(labels);
        for i=1:ngroups
            obj.label2idx(labels{i}) = i;
        end

        % Create 'trace <-> group' relationship
        for i=1:N           
            obj.group(i) = obj.label2idx( db_raw{i}.label );
        end               

        obj.trace = db_raw;
    end
      
    %% size method   
    % db.size        = database size
    % db.size(label) = size of a particular label
    function ret = size( obj, label )       
        % db.size
        if nargin < 2
            ret = length(obj.trace);
            return;
        end
        
        % db.size(label)
        ret = obj.sizes(label);
    end

    %% get labels
    function ret = labels( obj, i )
        if nargin < 2
            ret = keys(obj.sizes);
            return;
        end
        
        ret = obj.idx2label(i);
    end
    
    %% idx2label
    function ret = idx2label( obj, i )
        ret = obj.labels{i};
    end

    %% plot
    function plot( obj, total_time, set_of_labels, begin, n, m )
        if nargin < 2
            total_time = 0.25;
        end
        if nargin < 3
            set_of_labels = obj.labels;
        end
        if nargin < 4
            begin = 1;
        end
        if nargin < 5
            n = 2;
        end
        if nargin < 6
            m = 5;
        end

        figure(1);
        mat_labels = cell2mat( values(obj.label2idx, set_of_labels) );   % cell to mat
        MAX   = max( cell2mat( values(obj.sizes, set_of_labels) ) );     % common maximum
        i = 0;
        for idx=begin:MAX
            for label=mat_labels
                if( idx <= obj.size(obj.idx2label(label)) ) 
                    subplot( obj, label, i, idx, total_time, n, m );
                    i = i + 1;
                    fprintf('label: %s idx: %d, i: %d\n', ...
                             obj.idx2label(label), idx, i );
                end
            end
        end          
    end
    
    % subplot
    function subplot( obj, label, pos, idx, total_time, n, m )
        subplot(n, m, mod(pos,n*m)+1 )

        gindex = grp2idx(obj.group);
        traces = obj.trace(gindex==label);

        x = traces{idx}.channel{1};
        y = traces{idx}.channel{2};

        x = (x-min(x))/(max(x)-min(x));
        y = (y-min(y))/(max(y)-min(y));
        
        draw_trace( x, -y+1, total_time);
    end    
    
    %% Feature Extraction
    function obj = feature_extraction( obj, m, d, normalize )
        if ~exist('normalize', 'var')
            normalize = false;
        end
        
        
        for i=1:obj.size
            obj.features{i,m,d} = obj.trace{i}.feature_extraction( m, d, normalize );
        end        
    end
    
    end % methods block
end % classedf