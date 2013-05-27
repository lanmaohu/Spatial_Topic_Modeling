function [f] = logLikelihoodPwFunc(Pw0, Pwz, n_topic, n_word_zw, n_word_z)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pr0.
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% x, Pru, n_user, n_region, n_doc_ur, n_doc_u.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.


%% function value
f = 0;

%% precomputation
sum_wz = sumPwForAllTopic(Pw0, Pwz);
log_exp_sum_z = log(sum(exp(sum_wz))');

%% compute function value f
for z = 1:n_topic
    f = f + n_word_zw(z,:)*sum_wz(:,z) - n_word_z(z)*log_exp_sum_z(z);
end

