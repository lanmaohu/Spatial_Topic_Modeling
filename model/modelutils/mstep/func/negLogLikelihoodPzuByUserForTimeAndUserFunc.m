function [f, df] = negLogLikelihoodPzuByUserForTimeAndUserFunc(x, uu, Pz0, Pzt, Pzu, n_doc_ztu, n_doc_tu)

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
[n_topic, n_time] = size(Pzt);
sum_zt = zeros(n_topic,n_time);
log_exp_sum_t = zeros(n_time,1);
alpha_zt = zeros(n_topic,n_time);
for t = 1:n_time
    [sum_z, log_exp_sum, log_alpha_z, alpha_z] = alphaForAUserAndATime(Pz0, Pzt, Pzu, t, uu);
    sum_zt(:,t) = sum_z;
    log_exp_sum_t(t) = log_exp_sum;
    alpha_zt(:,t) = alpha_z;
end

% [n_topic,n_region] = size(Pzr);
% sum_zr = zeros(n_topic,n_region);
% for r = 1:n_region
%     sum_zr(:,r) = sumPzForAUserAndARegion(Pz0, Pzr, Pzu, r, uu);
% end
% exp_sum_zr = exp(sum_zr);
% exp_sum_r = sum(exp_sum_zr);
% log_exp_sum_r = log(exp_sum_r);

%% compute function value f
% vector version
for t = 1:n_time
    f = f + n_doc_ztu(:,t,uu)'*sum_zt(:,t)- n_doc_tu(t,uu)*log_exp_sum_t(t);
end

%% compute derivative value of function df
% vector version
for t = 1:n_time
    df(:) = df(:) + n_doc_ztu(:,t,uu) - n_doc_tu(t,uu) * alpha_zt(:,t);
end


%% negative
f = -f;
df = -df;




