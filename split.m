% split db
function [db_split, map_labels] = split( db )
    N = length(db);
    
    idx = containers.Map;   % label -> number of labels
    for i=1:N
        % Current label
        current_label = db{i}.label;
        
        % create map
        if  idx.isKey( current_label ) == 0
            idx( current_label ) = 1;
        else
            idx( current_label ) = idx( current_label ) + 1;
        end       
        
        % create database
        db_split{ current_label, idx(current_label) } = db{i};
    end
    
    map_labels = idx;
end