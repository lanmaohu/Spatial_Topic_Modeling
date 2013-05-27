function [f] = sumPzForAUser(Pz0, Pzu, u)

% function is f = theta^0 + theta_u^{user}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pz0, Pzu, u.
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a vector of size n_topic.

f = Pz0 + Pzu(:,u);
