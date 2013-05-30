function [f, df] = negLogLikelihoodPztByTimeForTimeAndUserFunc(x, tt, Pz0, Pzt, Pzu, n_doc_ztu, n_doc_tu)

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
Pzt(:, tt) = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[n_topic,n_user] = size(Pzu);
sum_zu = zeros(n_topic,n_user);
log_exp_sum_u = zeros(n_user,1);
alpha_zu = zeros(n_topic,n_user);
for u = 1:n_user
    [sum_z, log_exp_sum, log_alpha_z, alpha_z] = alphaForAUserAndATime(Pz0, Pzt, Pzu, tt, u);
    sum_zu(:,u) = sum_z;
    log_exp_sum_u(u) = log_exp_sum;
    alpha_zu(:,u) = alpha_z;
end

% exp_sum_zu = exp(sum_zu);
% exp_sum_u = sum(exp_sum_zu);
% log_exp_sum_u = log(exp_sum_u);


%% compute function value f
% vector version
for u = 1:n_user
    f = f + n_doc_ztu(:,tt,u)'*sum_zu(:,u)- n_doc_tu(tt,u)*log_exp_sum_u(u);
end

%% compute derivative value of function df
% vector version
for u = 1:n_user
    df(:) = df(:) + n_doc_ztu(:,tt,u) - n_doc_tu(tt,u) * alpha_zu(:,u);
end

%% negative
f = -f;
df = -df;



