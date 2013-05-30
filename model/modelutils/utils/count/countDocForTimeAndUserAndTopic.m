function [n_doc_ztu, n_doc_tu] = countDocForTimeAndUserAndTopic(n_user, n_topic, n_time, doc_topic, tweet_user, tweet_time)

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
n_doc_ztu = zeros(n_topic, n_time, n_user);
n_doc_tu = zeros(n_time, n_user);
for d = 1:n_doc % O(d)
    u = tweet_user(d);
    z = doc_topic(d);
    t = tweet_time(d);
    n_doc_ztu(z,t,u) = n_doc_ztu(z,t,u) + 1;
    n_doc_tu(t,u) = n_doc_tu(t,u) + 1;
end