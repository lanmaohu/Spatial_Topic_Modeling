function [f, df] = negLogLikelihoodPi0ForSTTFFunc(x, Piz, Pit, kernel, mu, location_coordinate, n_topic, n_region, n_location, n_time, n_doc_zrit, n_doc_zrt)

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
[sum_irzt, log_exp_sum_rzt, log_delta_irzt, delta_irzt] = deltaForAllTopicForAllTimeForAllRegion(Pi0, Piz, Pit, kernel, mu, location_coordinate);

%% compute function value f
for t = 1:n_time
    for z = 1:n_topic
        for r = 1:n_region
            f = f + reshape(n_doc_zrit(z,r,:,t),1,n_location) * sum_irzt(:,r,z,t) - n_doc_zrt(z,r,t)*log_exp_sum_rzt(r,z,t);
        end
    end
end

%% compute derivative value of function df
% vector version
for t = 1:n_time
    for z = 1:n_topic
        for r = 1:n_region
            df(:) = df(:) + reshape(n_doc_zrit(z,r,:,t), n_location, 1) - n_doc_zrt(z,r,t) * delta_irzt(:,r,z,t);
        end
    end
end

%% negative
f = -f;
df = -df;

