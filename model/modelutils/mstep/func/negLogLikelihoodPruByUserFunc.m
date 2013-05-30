function [f, df] = negLogLikelihoodPruByUserFunc(x, uu, Pr0, Pru, n_doc_ur, n_doc_u)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pw0.
%
% Author:	Bo Hu 2013-01-16
%
% Inputs -----------------------------------------------------------------
% D is the dimension of x.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.


%% function value
Pru(:,uu) = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[sum_r, log_exp_sum, log_beta_r, beta_r] = betaForAUser(Pr0, Pru, uu);

% sum_r = sumPrForAUser(Pr0, Pru, uu);
% exp_sum_r = exp(sum_r);
% exp_sum = sum(exp_sum_r);
% log_exp_sum = log(exp_sum);

%% compute function value f
% vector version
f = n_doc_ur(uu,:)*sum_r - n_doc_u(uu)*log_exp_sum;

% for r = 1:n_region
%     f = f + n_doc_ur(uu,r)*sum_r(r);
% end
% f = f - n_doc_u(uu)*log_exp_sum;

%% compute derivative value of function df
% vector version
df = n_doc_ur(uu,:)' - n_doc_u(uu)*beta_r;

% for r = 1:n_region
%     df(r) = df(r) + n_doc_ur(uu,r) - n_doc_u(uu)*(exp_sum_r(r)/exp_sum);
% end

%% negative
f = -f;
df = -df;



