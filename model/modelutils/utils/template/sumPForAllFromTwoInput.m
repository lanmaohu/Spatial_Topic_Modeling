function [f] = sumPForAllFromTwoInput(Px0, Pxy)

% function is f = Px0 + Pxy
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Px0, Pxy
%
% Outputs ----------------------------------------------------------------
% f is a matrix of size [n_row, n_col]

[n_row, n_col] = size(Pxy);
if n_row ~= length(Px0)
    fprintf('ERROR in func sumPForAllFromTwoInput: number of row is not consistent\n');
end
f = repmat(Px0, 1, n_col) + Pxy;
