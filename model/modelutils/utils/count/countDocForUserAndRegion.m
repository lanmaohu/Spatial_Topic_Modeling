function [n_doc_ur, n_doc_u] = countDocForUserAndRegion(n_user, n_region, doc_region, tweet_user)

% function is to count number of docs for user and region: d(u,r) and d(u)
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% n_user, n_region, doc_region, tweet_user.
%
% Outputs ----------------------------------------------------------------
% d(u,r): n_doc_ur is a matrix of size [n_user, n_region], where elements represent the
% number of docs. d(u): n_doc_u is a vector of length n_user, where elements
% represent the number of docs.

n_doc = length(doc_region);
n_doc_ur = zeros(n_user, n_region);
n_doc_u = zeros(n_user, 1);
for d = 1:n_doc % O(d)
    u = tweet_user(d);
    r = doc_region(d);
    n_doc_ur(u,r) = n_doc_ur(u,r) + 1;
    n_doc_u(u) = n_doc_u(u) + 1;
end