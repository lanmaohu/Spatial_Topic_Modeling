function [f, df] = negLogLikelihoodPizByTopicForSTFunc(x, z, Pi0, Piz, kernel, mu, location_location, n_region, n_location, n_doc_zri, n_doc_zr)

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
[sum_z_ir, log_exp_sum_z_r, log_delta_z_ir, delta_z_ir] = deltaForATopicForAllRegion(Pi0, Piz, kernel, mu, location_location, z);    

%% compute function value f
for r = 1:n_region
    f = f + reshape(n_doc_zri(z,r,:),1,n_location) * sum_z_ir(:,r) - n_doc_zr(z,r)*log_exp_sum_z_r(r);
end

%% compute derivative value of function df
% vector version
for r = 1:n_region
    df = df + reshape(n_doc_zri(z,r,:), n_location, 1) - n_doc_zr(z,r)*delta_z_ir(:,r);
end
% for i = 1:n_location
%     df(i) = df(i) + n_doc_zi(zz,i) - n_doc_z(zz)*(exp_sum_i(i)/exp_sum);
% end

f = -f;
df = -df;


