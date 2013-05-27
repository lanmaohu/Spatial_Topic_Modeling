function [n_doc_izu, n_doc_zu] = countDocForTopicAndLocationAndUser(n_user, n_topic, n_location, doc_topic, tweet_location_index, tweet_user)

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
n_doc_izu = cell(n_user, 1);
for u = 1:n_user
    n_doc_izu{u} = sparse(n_location, n_topic);
end
n_doc_zu = zeros(n_topic, n_user);
for d = 1:n_doc % O(d)
    z = doc_topic(d);
    i = tweet_location_index(d);
    u = tweet_user(d);
    n_doc_izu{u}(i,z) = n_doc_izu{u}(i,z) +1;
    n_doc_zu(z,u) = n_doc_zu(z,u) + 1;
end