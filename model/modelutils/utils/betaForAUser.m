function [sum_r, log_exp_sum, log_beta_r, beta_r] = betaForAUser(Pr0, Pru, u)

%% prepare
n_region = length(Pr0);

%% precomputation
sum_r = sumPrForAUser(Pr0, Pru, u);
log_exp_sum = log(sum(exp(sum_r)));

%% beta_r for user u
log_beta_r = sum_r - repmat(log_exp_sum, n_region, 1);
beta_r = exp(log_beta_r);
