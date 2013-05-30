function [sum_r_izt, exp_sum_zt, log_exp_sum_r_zt, delta_r_dzt] = deltaForAllTopicForAllTimeForARegion(Pi0, Piz, Pit, kernel, mu, location_coordinate, r)

%% prepare
[n_location, n_topic] = size(Piz);
[n_location, n_time] = size(Pit);
[n_dimension, n_region] = size(mu);

%% precomputation
sum_izt = sumPiForAllTopicForAllTime(Pi0, Piz, Pit);
[minus_di, norm_minus_i] = sumPlForARegion(mu, location_coordinate, r);
sum_r_izt = zeros(n_location,n_topic,n_time);
for z = 1:n_topic
    for t = 1:n_time
        sum_r_izt(:,z,t) = sum_r_izt(:,z,t) + sum_izt(:,z,t) + (-kernel/2) * norm_minus_i(:);
    end
end


exp_sum_zt = zeros(n_topic, n_time);
exp_sum_izt = exp(sum_izt);
sum_r_i = (-kernel/2) * norm_minus_i;
exp_sum_r_i = exp(sum_r_i);
for z = 1:n_topic
    for t = 1:n_time
        exp_sum_zt(z,t) = exp_sum_zt(z,t) + exp_sum_izt(:,z,t)' * exp_sum_r_i(:);
    end
end
log_exp_sum_r_zt = log(exp_sum_zt);

%% delta_r_z
delta_r_dzt = zeros(n_dimension,n_topic,n_time);
for dim = 1:n_dimension
    for z = 1:n_topic
        %     for i = 1:n_location
        for t = 1:n_time
            delta_r_dzt(dim,z,t) = delta_r_dzt(dim,z,t) +   sum(exp_sum_izt(:,z,t) .* exp_sum_r_i(:) .* (-kernel/2) .* (minus_di(dim,:)' ./ norm_minus_i(:)) );
        end
        %     end
    end
end
