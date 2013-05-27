function [sum_zu, log_exp_sum_u, log_alpha_zu, alpha_zu] = alphaForAllUser(Pz0, Pzu)

%% prepare
[n_topic, n_user] = size(Pzu);

%% precomputation
sum_zu = sumPzForAllUser(Pz0, Pzu);
log_exp_sum_u = log(sum(exp(sum_zu)));

%% log_beta_r for user u
log_alpha_zu = sum_zu - repmat(log_exp_sum_u, n_topic, 1);
alpha_zu = exp(log_alpha_zu);