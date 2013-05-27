function [f, df] = negLogLikelihoodPz0Func(x, Pzu, n_user, n_topic, n_doc_uz, n_doc_u)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pz0.
%
% Author:	Bo Hu 2013-01-18
%
% Inputs -----------------------------------------------------------------
% D is the dimension of x.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.

%% function value
Pz0 = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[sum_zu, log_exp_sum_u, log_alpha_zu, alpha_zu] = alphaForAllUser(Pz0, Pzu);

% sum_zu = sumPzForAllUser(Pz0, Pzu);
% exp_sum_zu = exp(sum_zu);
% exp_sum_u = sum(exp_sum_zu)';
% log_exp_sum_u = log(exp_sum_u);

%% compute function value f
% vector version
for u = 1:n_user
    f = f + n_doc_uz(u,:)*sum_zu(:,u) - n_doc_u(u)*log_exp_sum_u(u);
end

% for u = 1:n_user
%    for z = 1:n_topic
%        f = f + n_doc_uz(u,z)*sum_zu(z,u);
%    end
%    f = f - n_doc_u(u)*log_exp_sum_u(u);
% end

%% compute derivative value of function df
% vector version
for z = 1:n_topic
    df(z) = df(z) + sum(n_doc_uz(:,z)) - alpha_zu(z,:)*n_doc_u;
end

% for z = 1:n_topic
%     for u = 1:n_user
%         df(z) = df(z) + n_doc_uz(u,z) - n_doc_u(u) * (exp_sum_zu(z,u)/exp_sum_u(u));
%     end
% end

%% negative
f = -f;
df = -df;



