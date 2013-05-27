function [f] = sumPrForAllUser(Pr0, Pru)

% function is f = eta^0 + eta^{user}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pr0, Pru
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a matrix of size [n_region, n_user]

[n_region, n_user] = size(Pru);
f = repmat(Pr0, 1, n_user) + Pru;

