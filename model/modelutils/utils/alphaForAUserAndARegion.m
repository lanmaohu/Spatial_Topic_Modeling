function [sum_z, log_exp_sum, log_alpha_z, alpha_z] = alphaForAUserAndARegion(Pz0, Pzr, Pzu, r, u)

%% prepare
n_topic = length(Pz0);

%% precomputation
sum_z = sumPzForAUserAndARegion(Pz0, Pzr, Pzu, r, u);
log_exp_sum = log(sum(exp(sum_z)));

%% beta_r for user u
log_alpha_z = sum_z - repmat(log_exp_sum, n_topic, 1);
alpha_z = exp(log_alpha_z);
