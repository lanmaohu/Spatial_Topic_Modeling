function [n_word_zw, n_word_z] = countWordForTopicAndVocabulary(n_topic, n_word, doc_topic, tweet_word)

% function is to count number of words for topic and vocabulary: n(z,w) and
% n(z)
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% n_topic, n_word, doc_topic, tweet_word.
%
% Outputs ----------------------------------------------------------------
% n(z,w): n_word_zw is a matrix of size [n_topic, n_word], where elements represent the
% number of words. n(z): n_word_z is a vector of length n_topic, where elements
% represent the number of words.

n_word_zw = zeros(n_topic, n_word);
for z = 1:n_topic
    n_word_zw(z,:) = sum(tweet_word(find(doc_topic==z),:));
end
n_word_z = sum(n_word_zw')';

