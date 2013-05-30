function [n_doc_zrit, n_doc_zrt] = countDocForTopicAndRegionAndLocationAndTime(n_topic, n_region, n_location, n_time, doc_topic, doc_region, tweet_location_index, tweet_time)

% function is to count number of docs for topic and Location: d(z,i) and d(z)
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% n_user, n_topic, doc_topic, tweet_user.
%
% Outputs ----------------------------------------------------------------
% d(z,i): n_doc_zi is a matrix of size [n_topic, n_location], where elements represent the
% number of docs. d(z): n_doc_z is a vector of length n_topic, where elements
% represent the number of docs.

n_doc = length(doc_topic);
n_doc_zrit = zeros(n_topic, n_region, n_location, n_time);
n_doc_zrt = zeros(n_topic, n_region, n_time);
for d = 1:n_doc % O(d)
    z = doc_topic(d);
    r = doc_region(d);
    i = tweet_location_index(d);
    t = tweet_time(d);
    n_doc_zrit(z,r,i,t) = n_doc_zrit(z,r,i,t) + 1;
    n_doc_zrt(z,r,t) = n_doc_zrt(z,r,t) + 1;
end