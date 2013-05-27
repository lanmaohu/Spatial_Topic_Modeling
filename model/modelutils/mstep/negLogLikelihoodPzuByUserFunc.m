function [f, df] = negLogLikelihoodPzuByUserFunc(x, uu, Pz0, Pzu, n_doc_uz, n_doc_u)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pzr.
%
% Author:	Bo Hu 2013-01-08
%
% Inputs -----------------------------------------------------------------
% D is the dimension of x.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.


%% function value
Pzu(:,uu) = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[sum_z, log_exp_sum, log_alpha_z, alpha_z] = alphaForAUser(Pz0, Pzu, uu);

% sum_z = sumPzForAUser(Pz0, Pzu, uu);
% exp_sum_z = exp(sum_z);
% exp_sum = sum(exp_sum_z);
% log_exp_sum = log(exp_sum);

%% compute function value f
% vector version
f = n_doc_uz(uu,:)*sum_z - n_doc_u(uu)*log_exp_sum;

% for z = 1:n_topic
%     f = f + n_doc_uz(uu,z)*sum_z(z);
% end
% f = f - n_doc_u(uu)*log_exp_sum;

%% compute derivative value of function df
% vector version
df = n_doc_uz(uu,:)' - n_doc_u(uu) * alpha_z;

% for z = 1:n_topic
%     df(z) = df(z) + n_doc_uz(uu,z) - n_doc_u(uu) * (exp_sum_z(z)/exp_sum);
% end

%% negative
f = -f;
df = -df;




