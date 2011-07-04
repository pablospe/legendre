function db_features = feature_extraction_db( db, d )
    L = length(db);
%     L = 110;
    for i=1:L
%         i
        db_features{i} = feature_extraction( db{i}.channel{1}, db{i}.channel{2}, d );
    end
end
