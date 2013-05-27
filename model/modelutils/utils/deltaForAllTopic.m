function [sum_iz, log_exp_sum_z, log_delta_iz, delta_iz] = deltaForAllTopic(Pi0, Piz)

%% prepare
[n_location, n_topic] = size(Piz);

%% precomputation
sum_iz = sumPiForAllTopic(Pi0, Piz);
log_exp_sum_z = log(sum(exp(sum_iz)));

%% log_beta_r for user u
log_delta_iz = sum_iz - repmat(log_exp_sum_z, n_location, 1);
delta_iz = exp(log_delta_iz);