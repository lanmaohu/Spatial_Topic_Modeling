function [new_doc_region] = sampleRegion(tweet_user, tweet_location_index, tweet_time, doc_topic, n_doc, n_region, beta_ru, delta_irzt)
%
% This function samples region based on the probability of index.
%
% Author:	Bo Hu 2013-01-08
%
% Inputs -----------------------------------------------------------------
% user_tweet : user_tweet matrix (observed data)
%              user_tweet(i,j) stores whether tweet j authored by user i
% tweet_user : tweet_user matrix (observed data)
%              tweet_user(i,j) stores whether tweet i authored by user j
% tweet_word : tweet_word matrix (observed data)
%              tweet_word(i,j) stores number of occurrences of word j in tweet i
% tweet_location : tweet_location matrix (observed data)
%                   tweet_location(i, :) stores the lat/log of tweet i
% tweet_time : tweet_time matrix (observed data)
%                   tweet_time(i, :) stores the time of tweet i
% n_user : # of users
% n_doc : # of documents
% n_word : # of vocabulary
% n_trend : # of trends
% n_time : # of times
% n_region : # of regions
% n_topic : # of topics
%
% Outputs ----------------------------------------------------------------
%   o new_doc_region:  1 x N array representing the probability for every index for the 
%            N datapoints.     

%% fprintf('sample region\n');
p_new_doc_region = zeros(n_region, n_doc);

%% compute sampling probability
for d = 1:n_doc
    u = tweet_user(d);
    i = tweet_location_index(d);
    z = doc_topic(d);
    t = tweet_time(d);
    
    p_region = beta_ru(:,u) .* reshape(delta_irzt(i,:,z,t), n_region, 1);
    
    p_region(find(p_region<realmin)) = realmin;
    p_region(find(p_region>realmax)) = realmax;

    p_new_doc_region(:,d) = p_region;
end 
new_doc_region = sampleData(normalize(p_new_doc_region, 1))';

