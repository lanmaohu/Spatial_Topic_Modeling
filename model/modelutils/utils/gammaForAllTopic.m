function [sum_wz, log_exp_sum_z, log_gamma_wz, gamma_wz] = gammaForAllTopic(Pw0, Pwz)

%% prepare
[n_word, n_topic] = size(Pwz);

%% precomputation
sum_wz = sumPwForAllTopic(Pw0, Pwz);
log_exp_sum_z = log(sum(exp(sum_wz)));

%% log_gamma_wz for all topics
log_gamma_wz = sum_wz - repmat(log_exp_sum_z, n_word, 1);
gamma_wz = exp(log_gamma_wz);