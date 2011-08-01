function [pc_vec]=pca_kpm(features,N);
% PCA_KPM Compute top N principal components using eigs or svd.
% [pc_vec]=pca_kpm(features,N) 
%
% features(:,i) is the i'th example - each COLUMN is an observation
% pc_vec(:,j) is the j'th basis function onto which you should project the data
% using pc_vec' * features

[d ncases] = size(features);
fm=features-repmat(mean(features,2), 1, ncases);

if d*d < d*ncases
  options.disp = 0;
  C = cov(fm');
  [pc_vec, evals] = eigs(C, N, 'LM', options);
  fprintf('pca_kpm eigs\n');
else
  [U,D,V] = svds(fm', N);
  pc_vec = V;
  fprintf('pca_kpm svds\n');
end

