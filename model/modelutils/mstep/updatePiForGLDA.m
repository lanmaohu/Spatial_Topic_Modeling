function [Pi0, Piz] = updatePiForGLDA(Pi0, Piz, dist_iu, log_dist_iu, n_topic, n_user,        n_doc_izu, n_doc_zu,         optimFunc, options, penalty_delta_i0, penalty_delta_iz)

%% update Pi0, Piz.

%     tic
%     fprintf('maximize Pi0\n');
func = @(x)negLogLikelihoodPi0ForGLDAFunc(x, Piz, dist_iu, log_dist_iu, n_topic, n_user,       n_doc_izu, n_doc_zu);
x0 = Pi0;
Pi0 = optimFunc(func,x0,penalty_delta_i0*ones(size(x0)),options);
%     toc

%     tic
%     fprintf('maximize Piz\n');
new_Piz = zeros(size(Piz));
for z = 1:n_topic
    func = @(x)negLogLikelihoodPizByTopicForGLDAFunc(x, z, Pi0, Piz, dist_iu, n_user,        n_doc_izu, n_doc_zu);
    x0 = Piz(:,z);
    new_Piz(:,z) = optimFunc(func,x0,penalty_delta_iz*ones(size(x0)),options);
end
Piz = new_Piz;
clear new_Piz;
%     toc

