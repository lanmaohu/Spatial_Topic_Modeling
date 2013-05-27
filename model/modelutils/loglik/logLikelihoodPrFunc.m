function [f] = logLikelihoodPrFunc(Pr0, Pru, n_user, n_doc_ur, n_doc_u)

% This function returns the function value of the (general dimension) log likelihood function.
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pr0, Pru, n_user, n_region, n_doc_ur, n_doc_u.
%
% Outputs ----------------------------------------------------------------
% f is function value.


%% function value
f = 0;

%% precomputation
sum_ru = sumPrForAllUser(Pr0, Pru);
log_exp_sum_u = log(sum(exp(sum_ru)))';

%% compute function value f
for u = 1:n_user
   f = f + n_doc_ur(u,:)*sum_ru(:,u) - n_doc_u(u)*log_exp_sum_u(u);
end

