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
end