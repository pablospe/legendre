% split db
function db_split = split( db )
    N = length(db);
    indices = zeros(1,10);
    for i=1:N
        idx = str2num(db{i}.label);

        if  db{i}.label == '0'
            idx = 10;
        end

        indices(idx) = indices(idx)+1;

        db_split{idx,indices(idx)} = db{i};
    end
end