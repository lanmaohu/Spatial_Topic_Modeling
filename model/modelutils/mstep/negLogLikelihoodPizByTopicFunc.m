function [f, df] = negLogLikelihoodPizByTopicFunc(x, zz, Pi0, Piz, n_doc_zi, n_doc_z)

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
Piz(:,zz) = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[sum_i, log_exp_sum, log_delta_i, delta_i] = deltaForATopic(Pi0, Piz, zz);    

%% compute function value f
% vector version
f = n_doc_zi(zz,:)*sum_i - n_doc_z(zz)*log_exp_sum;

% for i = 1:n_location
%     f = f + n_doc_zi(zz,i)*sum_i(i);
% end
% f = f - n_doc_z(zz)*log_exp_sum;

%% compute derivative value of function df
% vector version
df = n_doc_zi(zz,:)' - n_doc_z(zz)*delta_i;

% for i = 1:n_location
%     df(i) = df(i) + n_doc_zi(zz,i) - n_doc_z(zz)*(exp_sum_i(i)/exp_sum);
% end

f = -f;
df = -df;



