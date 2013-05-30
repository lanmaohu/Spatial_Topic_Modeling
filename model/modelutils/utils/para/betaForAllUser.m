function [sum_ru, log_exp_sum_u, log_beta_ru, beta_ru] = betaForAllUser(Pr0, Pru)

%% prepare
[n_region, n_user] = size(Pru);

%% precomputation
sum_ru = sumPrForAllUser(Pr0, Pru);
log_exp_sum_u = log(sum(exp(sum_ru)));

%% log_beta_r for user u
log_beta_ru = sum_ru - repmat(log_exp_sum_u, n_region, 1);
beta_ru = exp(log_beta_ru);