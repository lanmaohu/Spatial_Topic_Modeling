function [sum_i, exp_sum_u, log_exp_sum_u] = deltaForATopicForGLDA(Pi0, Piz, dist_iu, z)

%% prepare
[n_location, n_user] = size(dist_iu);

%% precomputation
sum_i = sumPiForATopic(Pi0, Piz, z);
exp_sum_i = exp(sum_i);

exp_sum_u = zeros(n_user, 1);
for u = 1:n_user
    exp_sum_u(u) = exp_sum_u(u) + dist_iu(:,u)' * exp_sum_i(:);
end
log_exp_sum_u = log(exp_sum_u);
