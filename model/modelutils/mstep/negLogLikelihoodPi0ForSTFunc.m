function [f, df] = negLogLikelihoodPi0ForSTFunc(x, Piz, kernel, mu, location_location, n_topic, n_region, n_location, n_doc_zri, n_doc_zr)

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
[sum_irz, log_exp_sum_rz, log_delta_irz, delta_irz] = deltaForAllTopicForAllRegion(Pi0, Piz, kernel, mu, location_location);
 
%% compute function value f
for z = 1:n_topic
    for r = 1:n_region
        f = f + reshape(n_doc_zri(z,r,:),1,n_location) * sum_irz(:,r,z) - n_doc_zr(z,r)*log_exp_sum_rz(r,z);
    end
end

%% compute derivative value of function df
% vector version 
for z = 1:n_topic
    for r = 1:n_region
        df(:) = df(:) + reshape(n_doc_zri(z,r,:), n_location, 1) - n_doc_zr(z,r) * delta_irz(:,r,z);
    end
end

%% negative
f = -f;
df = -df;

