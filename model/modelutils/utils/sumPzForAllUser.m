function [f] = sumPzForAllUser(Pz0, Pzu)

% function is f = theta^0 + theta^{user}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pz0, Pzu
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a matrix of size [n_topic, n_user]

[n_topic, n_user] = size(Pzu);
f = repmat(Pz0, 1, n_user) + Pzu;
