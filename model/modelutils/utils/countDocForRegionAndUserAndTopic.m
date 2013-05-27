function [n_doc_zru, n_doc_ru] = countDocForRegionAndUserAndTopic(n_region, n_user, n_topic, doc_region, doc_topic, tweet_user)

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
n_doc_zru = zeros(n_topic, n_region, n_user);
n_doc_ru = zeros(n_region, n_user);
for d = 1:n_doc % O(d)
    u = tweet_user(d);
    z = doc_topic(d);
    r = doc_region(d);
    n_doc_zru(z,r,u) = n_doc_zru(z,r,u) + 1;
    n_doc_ru(r,u) = n_doc_ru(r,u) + 1;
end