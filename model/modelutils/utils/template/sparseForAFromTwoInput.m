function [sum_x, log_exp_sum, log_sparse_x, sparse_x] = sparseForAFromTwoInput(Px0, Pxy, y)

%% prepare
n_row = length(Px0);

%% precomputation
sum_x = sumPForAFromTwoInput(Px0, Pxy, y);
log_exp_sum = log(sum(exp(sum_x)));

%% sparseForAFromTwoInput for y
log_sparse_x = sum_x - repmat(log_exp_sum, n_row, 1);
sparse_x = exp(log_sparse_x);
