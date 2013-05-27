function [f] = sumPwForAllTopic(Pw0, Pwz)

% function is f = phi^0 + phi^{topic}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pw0, Pwz
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a matrix of size [n_word, n_topic]

[n_word, n_topic] = size(Pwz);
f = repmat(Pw0, 1, n_topic) + Pwz;
