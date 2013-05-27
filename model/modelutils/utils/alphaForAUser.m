function [sum_z, log_exp_sum, log_alpha_z, alpha_z] = alphaForAUser(Pz0, Pzu, u)

%% prepare
n_topic = length(Pz0);

%% precomputation
sum_z = sumPzForAUser(Pz0, Pzu, u);
log_exp_sum = log(sum(exp(sum_z)));

%% beta_r for user u
log_alpha_z = sum_z - repmat(log_exp_sum, n_topic, 1);
alpha_z = exp(log_alpha_z);
