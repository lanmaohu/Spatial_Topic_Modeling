function [sum_z_ir, log_exp_sum_z_r, log_delta_z_ir, delta_z_ir] = deltaForATopicForAllRegion(Pi0, Piz, kernel, mu, location_location, z)

%% prepare
[n_location, n_topic] = size(Piz);
[n_dimension, n_region]= size(mu);

%% precomputation
sum_i = sumPiForATopic(Pi0, Piz, z);
[minus_dir, norm_minus_ir] = sumPlForAllRegion(mu, location_location);
sum_z_ir = zeros(n_location, n_region);
% for i = 1:n_location
    for r = 1:n_region
        sum_z_ir(:,r) = sum_z_ir(:,r) + sum_i(:) + (-kernel/2) * norm_minus_ir(:,r);
    end
% end

log_exp_sum_z_r = zeros(n_region, 1);
exp_sum_i = exp(sum_i);
exp_sum_ir = exp((-kernel/2) * norm_minus_ir);
for r = 1:n_region
    log_exp_sum_z_r(r) = log(sum(exp_sum_i(:) .* exp_sum_ir(:,r)));
end

%% log_delta_irz and delta_irz
log_delta_z_ir = zeros(n_location, n_region);
% for i = 1:n_location
    for r = 1:n_region
        log_delta_z_ir(:,r) = sum_z_ir(:,r) - repmat(log_exp_sum_z_r(r), n_location, 1);
    end    
% end
delta_z_ir = exp(log_delta_z_ir);