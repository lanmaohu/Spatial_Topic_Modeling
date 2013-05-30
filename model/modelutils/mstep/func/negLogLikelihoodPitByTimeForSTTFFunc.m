function [f, df] = negLogLikelihoodPitByTimeForSTTFFunc(x, t, Pi0, Piz, Pit, kernel, mu, location_coordinate, n_topic, n_region, n_location, n_doc_zrit, n_doc_zrt)

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
Pit(:,t) = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[sum_irz, log_exp_sum_rz, log_delta_irz, delta_irz] = deltaForAllTopicForATimeForAllRegion(Pi0, Piz, Pit, kernel, mu, location_coordinate, t);

%% compute function value f
for z = 1:n_topic
    for r = 1:n_region
        f = f + reshape(n_doc_zrit(z,r,:,t),1,n_location) * sum_irz(:,r,z) - n_doc_zrt(z,r,t)*log_exp_sum_rz(r,z);
    end
end

%% compute derivative value of function df
% vector version
for z = 1:n_topic
    for r = 1:n_region
        df(:) = df(:) + reshape(n_doc_zrit(z,r,:,t), n_location, 1) - n_doc_zrt(z,r,t) * delta_irz(:,r,z);
    end
end


%% negative
f = -f;
df = -df;

