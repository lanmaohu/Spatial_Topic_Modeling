function [sum_irt, log_exp_sum_rt, log_delta_irt, delta_irt] = deltaForATopicForAllTimeForAllRegion(Pi0, Piz, Pit, kernel, mu, location_coordinate, z)

%% prepare
[n_location, n_topic] = size(Piz);
[n_location, n_time] = size(Pit);
[n_dimension, n_region]= size(mu);

%% precomputation
sum_it = zeros(n_location, n_time);
for t = 1:n_time
    sum_it(:,t) = sumPiForATopicForATime(Pi0, Piz, Pit, z, t);
end
[minus_dir, norm_minus_ir] = sumPlForAllRegion(mu, location_coordinate);

sum_irt = zeros(n_location, n_region, n_time);
% for i = 1:n_location % vectorize!!!
for t = 1:n_time
    for r = 1:n_region
        sum_irt(:,r,t) = sum_irt(:,r,t) + sum_it(:,t) + (-kernel/2) * norm_minus_ir(:,r);
    end
end
% end

exp_sum_rt = zeros(n_region, n_time);
exp_sum_it = exp(sum_it);
exp_sum_ir = exp((-kernel/2) * norm_minus_ir);
for t = 1:n_time
    for r = 1:n_region
        exp_sum_rt(r,t) = exp_sum_rt(r,t) + exp_sum_it(:,t)' * exp_sum_ir(:,r);
    end
end
log_exp_sum_rt = log(exp_sum_rt);

%% log_delta_ir and delta_ir
log_delta_irt = zeros(n_location, n_region, n_time);
% for i = 1:n_location % vectorize!!!
for t = 1:n_time
    for r = 1:n_region
            log_delta_irt(:,r,t) = sum_irt(:,r,t) - log_exp_sum_rt(r,t);
    end    
end
% end
delta_irt = exp(log_delta_irt);