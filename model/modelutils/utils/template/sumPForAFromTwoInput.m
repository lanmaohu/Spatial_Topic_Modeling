function [f] = sumPForAFromTwoInput(Px0, Pxy, y)

% function is f = Px0 + Pxy(:,y)
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Px0, Pxy, y
%
% Outputs ----------------------------------------------------------------
% f is a vector of size n_row

[n_row, n_col] = size(Pxy);
if n_row ~= length(Px0)
    fprintf('ERROR in func sumPForAFromTwoInput: number of row is not consistent\n');
end
f = Px0 + Pxy(:,y);
