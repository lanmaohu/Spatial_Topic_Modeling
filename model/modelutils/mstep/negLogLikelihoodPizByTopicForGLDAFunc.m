function [f, df] = negLogLikelihoodPizByTopicForGLDAFunc(x, z, Pi0, Piz, dist_iu, n_user,      n_doc_izu, n_doc_zu)

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
Piz(:,z) = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[sum_i, exp_sum_u, log_exp_sum_u] = deltaForATopicForGLDA(Pi0, Piz, dist_iu, z);
exp_sum_i = exp(sum_i); 

%% compute function value f
for u = 1:n_user
    f = f + n_doc_izu{u}(:,z)' * sum_i(:) - n_doc_zu(z,u) * log_exp_sum_u(u);
end
% n_doc = length(doc_topic);
% for d = 1:n_doc
%     u = tweet_user(d);
%     i = tweet_location_index(d);
%     zz = doc_topic(d);
%     if zz == z
%         f = f + sum_i(i) - log_exp_sum_u(u);
%     end
% end


%% compute derivative value of function df
% vector version
for u = 1:n_user
    df = df + n_doc_izu{u}(:,z) - n_doc_zu(z,u) * (exp_sum_i(:) .* dist_iu(:,u)) / exp_sum_u(u);
end
% n_doc = length(doc_topic);
% for d = 1:n_doc
%     u = tweet_user(d);
%     i = tweet_location_index(d);
%     zz = doc_topic(d);
%     if zz == z
%         df(i) = df(i) + 1 -  exp_sum_i(i) * dist_iu(i,u) / exp_sum_u(u);
%     end
% end

f = -f;
df = -df;



