function out = rectintFast(A, B)
%RECTINT Rectangle intersection area.
% Same as built-in rectint, except it's faster.
% Each ROW is a position vector

% we call repmatC instead of repmat

leftA = A(:,1);
bottomA = A(:,2);
rightA = leftA + A(:,3);
topA = bottomA + A(:,4);

leftB = B(:,1)';
bottomB = B(:,2)';
rightB = leftB + B(:,3)';
topB = bottomB + B(:,4)';

numRectA = size(A,1);
numRectB = size(B,1);

if numRectB > 1
  leftA = repmatC(leftA, 1, numRectB);
  bottomA = repmatC(bottomA, 1, numRectB);
  rightA = repmatC(rightA, 1, numRectB);
  topA = repmatC(topA, 1, numRectB);
end

if numRectA > 1
  leftB = repmatC(leftB, numRectA, 1);
  bottomB = repmatC(bottomB, numRectA, 1);
  rightB = repmatC(rightB, numRectA, 1);
  topB = repmatC(topB, numRectA, 1);
end

out = (max(0, min(rightA, rightB) - max(leftA, leftB))) .* ...
    (max(0, min(topA, topB) - max(bottomA, bottomB)));
