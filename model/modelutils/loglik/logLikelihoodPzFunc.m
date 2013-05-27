function [f] = logLikelihoodPzFunc(Pz0, Pzu, n_user, n_doc_uz, n_doc_u)

% This function returns the function value of the (general dimension) log likelihood function.
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pz0, Pzu, n_user, n_topic, n_doc_uz, n_doc_u.
%
% Outputs ----------------------------------------------------------------
% f is function value.


%% function value
f = 0;

%% precomputation
sum_zu = sumPzForAllUser(Pz0, Pzu);
log_exp_sum_u = log(sum(exp(sum_zu)))';

%% compute function value f
for u = 1:n_user
    f = f + n_doc_uz(u,:)*sum_zu(:,u)- n_doc_u(u)*log_exp_sum_u(u);
end

