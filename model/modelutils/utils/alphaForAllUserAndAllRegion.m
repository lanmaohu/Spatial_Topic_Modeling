function [sum_zru, log_exp_sum_ru, log_alpha_zru, alpha_zru] = alphaForAllUserAndAllRegion(Pz0, Pzr, Pzu)

%% prepare
[n_topic, n_region] = size(Pzr);
[n_topic, n_user] = size(Pzu);

%% precomputation
sum_zru = sumPzForAllUserAndAllRegion(Pz0, Pzr, Pzu);
log_exp_sum_ru = log(sum(exp(sum_zru)));

%% log_beta_r for user u
log_alpha_zru = sum_zru - repmat(log_exp_sum_ru, n_topic, 1);
alpha_zru = exp(log_alpha_zru);