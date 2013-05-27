function [f] = sumPrForAUser(Pr0, Pru, u)

% function is f = eta^0 + eta_u^{user}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pr0, Pru, u.
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a vector of size n_region.

f = Pr0 + Pru(:,u);

