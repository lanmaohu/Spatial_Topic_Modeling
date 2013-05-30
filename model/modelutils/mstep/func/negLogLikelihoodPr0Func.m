function [f, df] = negLogLikelihoodPr0Func(x, Pru, n_user, n_region, n_doc_ur, n_doc_u)

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
Pr0 = x;
f = 0;

%% derivative value
df = zeros(size(Pr0));

%% precomputation
[sum_ru, log_exp_sum_u, log_beta_ru, beta_ru] = betaForAllUser(Pr0, Pru);

% sum_ru = sumPrForAllUser(Pr0, Pru);
% exp_sum_ru = exp(sum_ru);
% exp_sum_u = sum(exp_sum_ru)';
% log_exp_sum_u = log(exp_sum_u);
 
%% compute function value f
% vector version
for u = 1:n_user
    f = f + n_doc_ur(u,:)*sum_ru(:,u) - n_doc_u(u)*log_exp_sum_u(u);
end

% for u = 1:n_user
%    for r = 1:n_region
%        f = f + n_doc_ur(u,r)*sum_ru(r,u);
%    end
%    f = f - n_doc_u(u)*log_exp_sum_u(u);
% end

%% compute derivative value of function df
% vector version
for r = 1:n_region
    df(r) = df(r) + sum(n_doc_ur(:,r)) - beta_ru(r,:) * n_doc_u;
end

% for r = 1:n_region
%     for u = 1:n_user
%         df(r) = df(r) + n_doc_ur(u,r) - n_doc_u(u) * (exp_sum_ru(r,u)/exp_sum_u(u));
%     end
% end

%% negative
f = -f;
df = -df;

