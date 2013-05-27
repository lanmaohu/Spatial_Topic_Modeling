function [sum_w, log_exp_sum, log_gamma_w, gamma_w] = gammaForATopic(Pw0, Pwz, z)

%% prepare
n_word = length(Pw0);

%% precomputation
sum_w = sumPwForATopic(Pw0, Pwz, z);
log_exp_sum = log(sum(exp(sum_w)));

%% delta_i for z
log_gamma_w = sum_w - repmat(log_exp_sum, n_word, 1);
gamma_w = exp(log_gamma_w);
