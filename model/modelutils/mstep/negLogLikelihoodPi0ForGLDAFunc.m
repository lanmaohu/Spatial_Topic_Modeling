function [f, df] = negLogLikelihoodPi0ForGLDAFunc(x, Piz, dist_iu, log_dist_iu, n_topic, n_user,    n_doc_izu, n_doc_zu)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pr0.
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% x, Piz, n_topic, n_location, n_doc_iz, n_doc_z.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.


%% function value
Pi0 = x;
f = 0;

%% derivative value
df = zeros(size(Pi0));

%% precomputation
[sum_iz, exp_sum_zu, log_exp_sum_zu] = deltaForAllTopicForGLDA(Pi0, Piz, dist_iu);
exp_sum_iz = exp(sum_iz);

%% compute function value f
for z = 1:n_topic
    for u = 1:n_user
        f = f + n_doc_izu{u}(:,z)' * (sum_iz(:,z) + log_dist_iu(:,u)) - n_doc_zu(z,u) * log_exp_sum_zu(z,u);
    end
end


%% compute derivative value of function df
for z = 1:n_topic
    for u = 1:n_user
        df = df + n_doc_izu{u}(:,z) - n_doc_zu(z,u) * exp_sum_iz(:,z) .* dist_iu(:,u) / exp_sum_zu(z,u);
    end
end


%% negative
f = -f;
df = -df;

