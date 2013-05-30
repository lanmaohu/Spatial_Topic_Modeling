function [f, df] = negLogLikelihoodPizByTopicForSTTFFunc(x, z, Pi0, Piz, Pit, kernel, mu, location_coordinate, n_region, n_location, n_time, n_doc_zrit, n_doc_zrt)

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
[sum_irt, log_exp_sum_rt, log_delta_irt, delta_irt] = deltaForATopicForAllTimeForAllRegion(Pi0, Piz, Pit, kernel, mu, location_coordinate, z);

%% compute function value f
for t = 1:n_time
    for r = 1:n_region
        f = f + reshape(n_doc_zrit(z,r,:,t),1,n_location) * sum_irt(:,r,t) - n_doc_zrt(z,r,t)*log_exp_sum_rt(r,t);
    end
end

%% compute derivative value of function df
% vector version
for t = 1:n_time
    for r = 1:n_region
        df(:) = df(:) + reshape(n_doc_zrit(z,r,:,t), n_location, 1) - n_doc_zrt(z,r,t) * delta_irt(:,r,t);
    end
end

%% negative
f = -f;
df = -df;



