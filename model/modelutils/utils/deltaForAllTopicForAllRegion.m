function [sum_irz, log_exp_sum_rz, log_delta_irz, delta_irz] = deltaForAllTopicForAllRegion(Pi0, Piz, kernel, mu, location_location)

%% prepare
[n_location, n_topic] = size(Piz);
[n_dimension, n_region]= size(mu);

%% precomputation
sum_iz = sumPiForAllTopic(Pi0, Piz);
[minus_dir, norm_minus_ir] = sumPlForAllRegion(mu, location_location);
sum_irz = zeros(n_location, n_region, n_topic);
% for i = 1:n_location % vectorize!!!
    for r = 1:n_region
        for z = 1:n_topic
            sum_irz(:,r,z) = sum_irz(:,r,z) + sum_iz(:,z) + (-kernel/2) * norm_minus_ir(:,r);
        end
    end
% end

exp_sum_rz = zeros(n_region, n_topic);
exp_sum_iz = exp(sum_iz);
exp_sum_ir = exp((-kernel/2) * norm_minus_ir);
for r = 1:n_region
    for z = 1:n_topic
        exp_sum_rz(r,z) = exp_sum_rz(r,z) + exp_sum_iz(:,z)' * exp_sum_ir(:,r);
    end
end
log_exp_sum_rz = log(exp_sum_rz);

%% log_delta_irz and delta_irz
log_delta_irz = zeros(n_location, n_region, n_topic);
% for i = 1:n_location % vectorize!!!
    for r = 1:n_region
        for z = 1:n_topic
            log_delta_irz(:,r,z) = sum_irz(:,r,z) - repmat(log_exp_sum_rz(r,z), n_location, 1);
        end
    end    
% end
delta_irz = exp(log_delta_irz);