function [sum_i, log_exp_sum, log_delta_i, delta_i] = deltaForATopic(Pi0, Piz, z)

%% prepare
n_location = length(Pi0);

%% precomputation
sum_i = sumPiForATopic(Pi0, Piz, z);
log_exp_sum = log(sum(exp(sum_i)));

%% delta_i for z
log_delta_i = sum_i - repmat(log_exp_sum, n_location, 1);
delta_i = exp(log_delta_i);
