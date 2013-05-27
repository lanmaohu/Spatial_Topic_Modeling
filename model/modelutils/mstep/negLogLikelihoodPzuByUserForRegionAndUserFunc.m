function [f, df] = negLogLikelihoodPzuByUserForRegionAndUserFunc(x, uu, Pz0, Pzr, Pzu, n_doc_zru, n_doc_ru)

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
[n_topic,n_region] = size(Pzr);
sum_zr = zeros(n_topic,n_region);
log_exp_sum_r = zeros(n_region,1);
alpha_zr = zeros(n_topic,n_region);
for r = 1:n_region
    [sum_z, log_exp_sum, log_alpha_z, alpha_z] = alphaForAUserAndARegion(Pz0, Pzr, Pzu, r, uu);
    sum_zr(:,r) = sum_z;
    log_exp_sum_r(r) = log_exp_sum;
    alpha_zr(:,r) = alpha_z;
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
for r = 1:n_region
    f = f + n_doc_zru(:,r,uu)'*sum_zr(:,r)- n_doc_ru(r,uu)*log_exp_sum_r(r);
end

%% compute derivative value of function df
% vector version
for z = 1:n_topic
    for r = 1:n_region
        df(z) = df(z) + n_doc_zru(z,r,uu) - n_doc_ru(r,uu) * alpha_zr(z,r);
    end
end

%% negative
f = -f;
df = -df;




