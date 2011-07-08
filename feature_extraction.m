function curves_features = feature_extraction( x, y, d )
% Legendre
    [x_est,x_alpha] = aprox_discreta(d, x);
    [y_est,y_alpha] = aprox_discreta(d, y);

% MinCuadrados
%     [x_est,x_alpha] = aprox_minCuadrado(d, x);
%     [y_est,y_alpha] = aprox_minCuadrado(d, y);

    curves_features = [x_alpha y_alpha];
end


% xest2 = aprox_discreta(15,x);
% yest2 = aprox_discreta(15,y);
% xest2 = xest2(1:end-1);
% yest2 = yest2(1:end-1);


% SETS = length(traces_x)/10-1;
% 
% for set = 0:SETS
%     for dig = 1:10
%         current = set*10 + dig
%         x = traces_x{current};
%         [x_est,x_alpha] = aprox_discreta(15, x);
% %         pause;
%         y = traces_y{current};
%         [y_est,y_alpha] = aprox_discreta(15, y);
% %         pause;
%         features{current} = [x_alpha y_alpha];
%     end
% end

% training = [];
% for i=1:20
%     training = [ training; features{i} ];
% end
% 
% group = [[1:10], [1:10]];

% sample = [];
% for i=21:30
%     r = randi([21 30],1);
% %     sample = [ sample; features{ r } ];
%     sample = [ sample; features{ i } ];
% end

% class = knnclassify(sample, training, group)