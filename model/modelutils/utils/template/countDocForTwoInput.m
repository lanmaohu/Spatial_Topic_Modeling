function [n_doc_xy, n_doc_y] = countDocForTwoInput(n_x, n_y, doc_x, doc_y)

% function is to count number of docs for user and topic: d(u,z) and d(u)
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% n_user, n_topic, doc_topic, tweet_user.
%
% Outputs ----------------------------------------------------------------
% d(u,z): n_doc_uz is a matrix of size [n_user, n_topic], where elements represent the
% number of docs. d(u): n_doc_u is a vector of length n_user, where elements
% represent the number of docs.

n_doc = length(doc_x);
n_doc_xy = zeros(n_x, n_y);
n_doc_y = zeros(n_y, 1);
for d = 1:n_doc % O(d)
    y = doc_y(d);
    x = doc_x(d);
    n_doc_xy(x,y) = n_doc_xy(x,y) + 1;
    n_doc_y(y) = n_doc_y(y) + 1;
end