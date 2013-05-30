function [f] = sumPzForAllUserAndAllTime(Pz0, Pzt, Pzu)

% function is f = theta^0 + theta^{user}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pz0, Pzu
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a matrix of size [n_topic, n_user]

[n_topic, n_time] = size(Pzt);
[n_topic, n_user] = size(Pzu);
f = zeros(n_topic, n_time, n_user);
for t = 1:n_time
    for u = 1:n_user
        f(:,t,u) = sumPzForAUserAndATime(Pz0, Pzt, Pzu, t, u);
    end
end
