function [f] = sumPiForAllTopic(Pi0, Piz)

% function is f = psi^0 + psi^{topic}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pi0, Piz
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a matrix of size [n_location, n_topic]

[n_location, n_topic] = size(Piz);
f = repmat(Pi0, 1, n_topic) + Piz;

