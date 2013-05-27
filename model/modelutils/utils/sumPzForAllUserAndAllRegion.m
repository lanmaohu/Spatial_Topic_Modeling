function [f] = sumPzForAllUserAndAllRegion(Pz0, Pzr, Pzu)

% function is f = theta^0 + theta^{user}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pz0, Pzu
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a matrix of size [n_topic, n_user]

[n_topic, n_region] = size(Pzr);
[n_topic, n_user] = size(Pzu);
f = zeros(n_topic, n_region, n_user);
for r = 1:n_region
    for u = 1:n_user
        f(:,r,u) = sumPzForAUserAndARegion(Pz0, Pzr, Pzu, r, u);
    end
end
