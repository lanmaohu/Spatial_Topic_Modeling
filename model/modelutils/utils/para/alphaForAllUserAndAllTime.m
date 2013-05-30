function [sum_ztu, log_exp_sum_tu, log_alpha_ztu, alpha_ztu] = alphaForAllUserAndAllTime(Pz0, Pzt, Pzu)

%% prepare
[n_topic, n_time] = size(Pzt);
[n_topic, n_user] = size(Pzu);

%% precomputation
sum_ztu = sumPzForAllUserAndAllTime(Pz0, Pzt, Pzu);
log_exp_sum_tu = log(sum(exp(sum_ztu)));

%% log_alpha_t for user u
log_alpha_ztu = sum_ztu - repmat(log_exp_sum_tu, n_topic, 1);
alpha_ztu = exp(log_alpha_ztu);