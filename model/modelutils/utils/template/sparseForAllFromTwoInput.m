function [sum_xy, log_exp_sum_y, log_sparse_xy, sparse_xy] = sparseForAllFromTwoInput(Px0, Pxy)

%% prepare
n_row = length(Px0);

%% precomputation
sum_xy = sumPForAllFromTwoInput(Px0, Pxy);
log_exp_sum_y = log(sum(exp(sum_xy)));

%% log_beta_r for user u
log_sparse_xy = sum_xy - repmat(log_exp_sum_y, n_row, 1);
sparse_xy = exp(log_sparse_xy);