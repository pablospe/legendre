classdef MethodFE < uint32
   enumeration
      moments_L             (1)   % Legendre - Time
      least_square_L        (2)
      moments_L_arc         (3)   % Legendre - Arc-Length
      least_square_L_arc    (4)
      moments_C             (5)   % Chebyshev
      least_square_C        (6)   
   end
end