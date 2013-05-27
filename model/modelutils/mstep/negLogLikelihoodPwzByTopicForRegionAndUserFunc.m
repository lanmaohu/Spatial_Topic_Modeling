function [f, df] = negLogLikelihoodPwzByTopicFunc(x, zz, Pw0, Pwz, n_word_zw, n_word_z)

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
Pwz(:,zz) = x; % reshape(x, n_word, n_topic);
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
sum_w = sumPwForATopic(Pw0, Pwz, zz);
exp_sum_w = exp(sum_w);
exp_sum = sum(exp_sum_w);
log_exp_sum = log(exp_sum);

%% compute function value f
% vector version
f = n_word_zw(zz,:)*sum_w - n_word_z(zz)*log_exp_sum;

% for w = 1:n_word
%     f = f + n_word_zw(zz,w)*sum_w(w);
% end
% f = f - n_word_z(zz)*log_exp_sum;

%% compute derivative value of function df
% vector version
df = n_word_zw(zz,:)' - n_word_z(zz)*(exp_sum_w/exp_sum);

% for w = 1:n_word
%     df(w) = df(w) + n_word_zw(zz,w) - n_word_z(zz)*(exp_sum_w(w)/exp_sum);
% end

f = -f;
df = -df;
