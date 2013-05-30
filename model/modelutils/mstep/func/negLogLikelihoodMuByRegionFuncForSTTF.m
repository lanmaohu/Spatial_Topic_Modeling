function [f, df] = negLogLikelihoodMuByRegionFuncForSTTF(x, r, mu, Pi0, Piz, Pit, kernel, location_coordinate, n_topic, n_location, n_time, n_doc_zrit, n_doc_zrt)

%% function value
mu(:,r) = x;
n_dimension = length(x);
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[minus_di, norm_minus_i] = sumPlForARegion(mu, location_coordinate, r); % 2 norm
[sum_r_izt, exp_sum_zt, log_exp_sum_r_zt, delta_r_dzt] = deltaForAllTopicForAllTimeForARegion(Pi0, Piz, Pit, kernel, mu, location_coordinate, r);

%% compute function value f
for z = 1:n_topic
    for t = 1:n_time
        f = f + reshape(n_doc_zrit(z,r,:,t),1,n_location) * sum_r_izt(:,z,t) - n_doc_zrt(z,r,t)*log_exp_sum_r_zt(z,t);
    end
end

%% compute derivative value of function df
for dim = 1:n_dimension
    for z = 1:n_topic
%         for i = 1:n_location
            for t = 1:n_time
                % vector version
                df(dim) = df(dim) + reshape(n_doc_zrit(z,r,:,t), 1, n_location) * (-kernel/2) * (minus_di(dim,:)'./norm_minus_i(:))   -       n_doc_zrt(z,r,t) * (delta_r_dzt(dim,z,t)/exp_sum_zt(z,t));
            end
%         end
    end
end

%% negative
f = -f;
df = -df;

