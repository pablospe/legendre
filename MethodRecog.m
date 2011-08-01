% Recognition methods
classdef MethodRecog < uint32
   enumeration
      euclidean   (1)
      cityblock   (2)
      mahalanobis (3)
      libsvm      (4)
      minkowski   (5)
      hmm         (6)
   end
end