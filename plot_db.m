function plot_db( db )
    
    figure(1);

    MAX = 110; % cantidad de sample por numeros
    
    db_split = split(db);
    
    for idx=1:MAX
        idx
        for i = 1:10 %[1 4 5 7]
            subplot_db( db_split, i, idx, 0.15 )
        end
    end

end

function subplot_db( db, pos, idx, total_time )
    subplot(2,5,pos)
    x = db{pos,idx}.channel{1};
    y = db{pos,idx}.channel{2};
    
    x = (x-min(x))/(max(x)-min(x));
    y = (y-min(y))/(max(y)-min(y));
     
    draw_trace( x, -y+1, total_time);
end