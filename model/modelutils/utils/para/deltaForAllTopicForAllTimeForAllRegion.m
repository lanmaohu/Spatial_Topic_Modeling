function [sum_irzt, log_exp_sum_rzt, log_delta_irzt, delta_irzt] = deltaForAllTopicForAllTimeForAllRegion(Pi0, Piz, Pit, kernel, mu, location_coordinate)

%% prepare
[n_location, n_topic] = size(Piz);
[n_location, n_time] = size(Pit);
[n_dimension, n_region]= size(mu);

%% precomputation
sum_izt = sumPiForAllTopicForAllTime(Pi0, Piz, Pit);
[minus_dir, norm_minus_ir] = sumPlForAllRegion(mu, location_coordinate);

sum_irzt = zeros(n_location, n_region, n_topic, n_time);
% for i = 1:n_location % vectorize!!!
for t = 1:n_time
    for r = 1:n_region
        for z = 1:n_topic
            sum_irzt(:,r,z,t) = sum_irzt(:,r,z,t) + sum_izt(:,z,t) + (-kernel/2) * norm_minus_ir(:,r);
        end
    end
end
% end

exp_sum_rzt = zeros(n_region, n_topic, n_time);
exp_sum_izt = exp(sum_izt);
exp_sum_ir = exp((-kernel/2) * norm_minus_ir);
for t = 1:n_time
    for r = 1:n_region
        for z = 1:n_topic
            exp_sum_rzt(r,z,t) = exp_sum_rzt(r,z,t) + exp_sum_izt(:,z,t)' * exp_sum_ir(:,r);
        end
    end
end
log_exp_sum_rzt = log(exp_sum_rzt);

%% log_delta_irz and delta_irz
log_delta_irzt = zeros(n_location, n_region, n_topic, n_time);
% for i = 1:n_location % vectorize!!!
for t = 1:n_time
    for r = 1:n_region
        for z = 1:n_topic
            log_delta_irzt(:,r,z,t) = sum_irzt(:,r,z,t) - log_exp_sum_rzt(r,z,t);
        end
    end    
end
% end
delta_irzt = exp(log_delta_irzt);