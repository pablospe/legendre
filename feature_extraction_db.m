function [db] = feature_extraction_db( db, d )
    L = length(db);
%     L = 110;
    for i=1:L
%         i
        db{i}.features = feature_extraction( db{i}.channel{1}, db{i}.channel{2}, d );
    end
end
