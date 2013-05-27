function [n_doc_uz, n_doc_u] = countDocForUserAndTopic(n_user, n_topic, doc_topic, tweet_user)

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

n_doc = length(doc_topic);
n_doc_uz = zeros(n_user, n_topic);
n_doc_u = zeros(n_user, 1);
for d = 1:n_doc % O(d)
    u = tweet_user(d);
    z = doc_topic(d);
    n_doc_uz(u,z) = n_doc_uz(u,z) + 1;
    n_doc_u(u) = n_doc_u(u) + 1;
end