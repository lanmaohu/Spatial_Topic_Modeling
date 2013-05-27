function [sum_iz, exp_sum_zu, log_exp_sum_zu] = deltaForAllTopicForGLDA(Pi0, Piz, dist_iu)

%% prepare
[n_location, n_topic] = size(Piz);
[n_location, n_user] = size(dist_iu);

%% precomputation
sum_iz = sumPiForAllTopic(Pi0, Piz);
exp_sum_iz = exp(sum_iz);

exp_sum_zu = zeros(n_topic, n_user);
for z = 1:n_topic
    for u = 1:n_user
        exp_sum_zu(z,u) = exp_sum_zu(z,u) + exp_sum_iz(:,z)' * dist_iu(:,u);
    end
end
log_exp_sum_zu = log(exp_sum_zu);
