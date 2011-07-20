function class = recognition( t, db, d, method )
    % Feature extraction method
    m = MethodFE.least_square_L;
    
    % trace features 
    curves_features = t.feature_extraction( m, d );
    
    % all features - db
    training = cell2mat( db.features(:, m, d) );
    group = db.group';
    
    % recognition
    class = single_test( curves_features, training, group, method );
end

