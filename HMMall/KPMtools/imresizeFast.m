function img = imresizeFast(img, nr, nc)
% For speed, first reduce by factors of 2, then apply imresize
% For reducing 1600x1200 to 160x120, this is 3.7 times faster.

if size(img,3) == 1 % blurDn does not work on color images
  while size(img,1) > 2*nr | size(img,2) > 2*nc
    img = blurDn(img,1);
  end
end
img = imresize(img, [nr+2 nc+2], 'bilinear', 40);
img = img(2:end-1, 2:end-1, :);  % remove edge fx


%%%%%%%%%

function imresizeFastDemo()

%nrows= 480; ncols = 640;
%nrows= 240; ncols = 320;
nrows = 1200; ncols = 1600;
img = zeros(nrows, ncols);
nr = 120; nc = 160;

% For speed, first reduce by factors of 2, then apply imresize
tic;
while size(img,1) > nr | size(img,2) > nc
  img = blurDn(img,1);
end
img = imresize(img, [nr nc], 'bilinear');
toc

img = zeros(nrows, ncols);
tic
img = imresize(img, [nr nc], 'bilinear');
toc
