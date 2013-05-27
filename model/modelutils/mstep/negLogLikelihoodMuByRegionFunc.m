function [f, df] = negLogLikelihoodMuByRegionFunc(x, r, mu, Pi0, Piz, kernel, location_location, n_topic, n_location, n_doc_zri, n_doc_zr)

%% function value
mu(:,r) = x;
n_dimension = length(x);
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[minus_di, norm_minus_i] = sumPlForARegion(mu, location_location, r); % 2 norm
[sum_r_iz, log_exp_sum_r_z, delta_r_dz] = deltaForAllTopicForARegion(Pi0, Piz, kernel, mu, location_location, r);

%% compute function value f
for z = 1:n_topic
    f = f + reshape(n_doc_zri(z,r,:),1,n_location) * sum_r_iz(:,z) - n_doc_zr(z,r)*log_exp_sum_r_z(z);
end

%% compute derivative value of function df
for z = 1:n_topic
    for i = 1:n_location
        % vector version
        df = df + n_doc_zri(z,r,i) * (-kernel/2) * (1/norm_minus_i(i)) * minus_di(:,i) - n_doc_zr(z,r) * (1/log_exp_sum_r_z(z)) * delta_r_dz(:,z);
    end
end

%% negative
f = -f;
df = -df;

