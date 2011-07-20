classdef test_data
    properties
        training
        testing       
        
        training_class
        testing_class
        
        degree
        method
    end
   
    methods       
        function obj = test_data( db, ...
                                  method, ...
                                  degree, ...
                                  training_domain, ...
                                  testing_domain )                             
            % Groups
            obj.training_class = db.group(training_domain)';
            obj.testing_class  = db.group(testing_domain)';

            % Extract features
            for d=degree
                obj.training{d} = cell2mat( db.features(training_domain,method,d) );
                obj.testing{d}  = cell2mat( db.features(testing_domain,method,d) );
            end
            
            obj.degree = degree;
            obj.method = method;
        end   
    end
end