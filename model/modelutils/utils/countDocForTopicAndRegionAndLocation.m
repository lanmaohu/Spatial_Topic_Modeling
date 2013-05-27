function [n_doc_zri, n_doc_zr] = countDocForTopicAndRegionAndLocation(n_topic, n_region, n_location, doc_topic, doc_region, tweet_location_index)

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
n_doc_zri = zeros(n_topic, n_region, n_location);
n_doc_zr = zeros(n_topic, n_region);
for d = 1:n_doc % O(d)
    z = doc_topic(d);
    r = doc_region(d);
    i = tweet_location_index(d);
    n_doc_zri(z,r,i) = n_doc_zri(z,r,i) + 1;
    n_doc_zr(z,r) = n_doc_zr(z,r) + 1;
end