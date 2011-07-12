classdef test_data
    properties
        training
        testing       
        
        training_class
        testing_class
        
        degree
        percentaje
        method
    end
   
    methods       
        function obj = test_data( db, method, degree, percentaje )           
            if nargin < 3
                degree=3:25;      % calculation for degree 3 to 25
            end
            
            if nargin < 4
                percentaje=0.9;   % training percentaje: 90%
            end
                       
            mat_labels = cell2mat(db.get_labels());

            for d=degree
                obj.training{d} = [];
                obj.testing{d}  = [];
                obj.training_class{d} = [];                
                obj.testing_class{d}  = [];

                for label=mat_labels
                    N = db.size(label);
                    r = randperm(N);

                    % r == [obj.training_domain obj.testing_domain]
                    training_domain = r(1:N*percentaje);
                    testing_domain  = r(N*percentaje+1:end);

                    % obj.training
                    for i=training_domain     
                        obj.training{d} = [ obj.training{d}; ... 
                                            db.get_trace(label,i).features{method,d} ];
                        obj.training_class{d} = [ obj.training_class{d}; label ];
                    end

                    % obj.testing
                    for i=testing_domain
                        obj.testing{d} = [ obj.testing{d}; ...
                                           db.get_trace(label,i).features{method,d} ];
                        obj.testing_class{d} = [ obj.testing_class{d}; label ];
                    end
                end
            end
            
            obj.degree = degree;
            obj.percentaje = percentaje;
            obj.method = method;
        end   
    end
end