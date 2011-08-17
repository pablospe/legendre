classdef MethodFE < uint32
   enumeration
      moments              (10)   % Moments

      moments_L             (1)   % Legendre - Time
      least_square_L        (2)
      moments_L_arc         (3)   % Legendre - Arc-Length
      least_square_L_arc    (4)

      least_square_C        (6)   % Chebyshev
      
      least_square_LS       (7)   % Legendre-Sobolev - Time
      least_square_LS_arc   (8)   % Legendre-Sobolev - Arc-Length
   end
   
    methods
        function string_name = get_string_name( obj )           
            switch(obj)
                case MethodFE.moments_L
                    string_name = 'moments_L';

                case MethodFE.moments_L_arc
                    string_name = 'moments_L_arc';

                case MethodFE.least_square_L
                    string_name = 'least_square_L';

                case MethodFE.least_square_L_arc
                    string_name = 'least_square_L_arc';

                case MethodFE.least_square_LS
                    string_name = 'least_square_LS';

                case MethodFE.least_square_LS_arc
                    string_name = 'least_square_LS_arc';

                case MethodFE.least_square_C
                    string_name = 'least_square_C';

                case MethodFE.moments
                    string_name = 'moments';
            end
        end

        
        function s = get_description( obj )
            switch(obj)
                case MethodFE.moments_L
                    s = 'Polynomails: Legendre - Method: Moments - Parameterization: time';

                case MethodFE.moments_L_arc
                    s = 'Polynomails: Legendre - Method: Moments - Parameterization: arc-length';

                case MethodFE.least_square_L
                    s = 'Polynomails: Legendre - Method: Least Square - Parameterization: time';

                case MethodFE.least_square_L_arc
                    s = 'Polynomails: Legendre - Method: Least Square - Parameterization: arc-length';

                case MethodFE.least_square_LS
                    s = 'Polynomails: Legendre-Sobolev - Method: Least Square - Parameterization: time';

                case MethodFE.least_square_LS_arc
                    s = 'Polynomails: Legendre-Sobolev - Method: Least Square - Parameterization: arc-length';

                case MethodFE.least_square_C
                    s = 'Polynomails: Chebyshev - Method: Least Square - Parameterization: time';

                case MethodFE.moments
                    s = 'Method: Moments as features';
            end
        end
        
    end % methods block          
end