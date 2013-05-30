function [f] = sumPiForAllTopicForAllTime(Pi0, Piz, Pit)

% function is f = psi^0 + psi^{topic}
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pi0, Piz
%
% Outputs ----------------------------------------------------------------
% f is function value, which is a matrix of size [n_location, n_topic]

[n_location, n_topic] = size(Piz);
[n_location, n_time] = size(Pit);
f = zeros(n_location, n_topic, n_time);
for z = 1:n_topic
    for t = 1:n_time
        f(:,z,t) = sumPiForATopicForATime(Pi0, Piz, Pit, z, t);
    end
end



