function db = feature_extraction_db( db, d )
    mat_labels = cell2mat(db.get_labels());
    for label=mat_labels
        for i=1:db.size(label)
            db.db{label,i}.features = feature_extraction( db.get_trace(label,i).channel{1}, ...
                                                          db.get_trace(label,i).channel{2}, d );
%             [num2cell(label),i]
        end
    end
end
