function [f] = sumPiForATopicForATime(Pi0, Piz, Pit, z, t)

% function is f = psi^0 + psi_z^{topic}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pi0, Piz, z.
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a vector of size n_location.

f = Pi0 + Piz(:,z) + Pit(:,t);

