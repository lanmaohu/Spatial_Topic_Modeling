function [Pi0, Piz] = updatePiForST(Pi0, Piz, kernel, mu, location_location, n_topic, n_region, n_location, n_doc_zri, n_doc_zr, optimFunc, options, penalty_delta_i0, penalty_delta_iz)

%% update Pi0, Piz.

%     tic
%     fprintf('maximize Pi0\n');
func = @(x)negLogLikelihoodPi0ForSTFunc(x, Piz, kernel, mu, location_location, n_topic, n_region, n_location, n_doc_zri, n_doc_zr);
x0 = Pi0;
Pi0 = optimFunc(func,x0,penalty_delta_i0*ones(size(x0)),options);
%     toc

%     tic
%     fprintf('maximize Piz\n');
new_Piz = zeros(size(Piz));
for z = 1:n_topic
    func = @(x)negLogLikelihoodPizByTopicForSTFunc(x, z, Pi0, Piz, kernel, mu, location_location, n_region, n_location, n_doc_zri, n_doc_zr);
    x0 = Piz(:,z);
    new_Piz(:,z) = optimFunc(func,x0,penalty_delta_iz*ones(size(x0)),options);
end
Piz = new_Piz;
clear new_Piz;
%     toc

