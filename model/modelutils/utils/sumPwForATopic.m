function [f] = sumPwForATopic(Pw0, Pwz, z)

% function is f = phi^0 + phi_z^{topic}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pw0, Pwz, z.
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a vector of size n_word.

f = Pw0 + Pwz(:,z);
