function [sum_r_iz, log_exp_sum_r_z, delta_r_dz] = deltaForAllTopicForARegion(Pi0, Piz, kernel, mu, location_location, r)

%% prepare
[n_location, n_topic] = size(Piz);
[n_dimension, n_region] = size(mu);

%% precomputation
sum_iz = sumPiForAllTopic(Pi0, Piz);
[minus_di, norm_minus_i] = sumPlForARegion(mu, location_location, r);
sum_r_iz = zeros(n_location,n_topic);
for z = 1:n_topic
    sum_r_iz(:,z) = sum_r_iz(:,z) + sum_iz(:,z) + (-kernel/2) * norm_minus_i(:);
end


exp_sum_z = zeros(n_topic, 1);
exp_sum_iz = exp(sum_iz);
sum_r_i = (-kernel/2) * norm_minus_i;
exp_sum_r_i = exp(sum_r_i);
for z = 1:n_topic
    exp_sum_z(z) = exp_sum_z(z) + exp_sum_iz(:,z)' * exp_sum_r_i(:);
end
log_exp_sum_r_z = log(exp_sum_z);

%% delta_r_z
delta_r_dz = zeros(n_dimension,n_topic);
for z = 1:n_topic
    for i = 1:n_location
        delta_r_dz(:,z) = delta_r_dz(:,z) +   exp_sum_iz(i,z) .* exp_sum_r_i(i) .* (-kernel/2) .* minus_di(:,i) ./ norm_minus_i(i) ;
    end
end

