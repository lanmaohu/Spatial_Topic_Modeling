function [mu] = updateMu(mu, Pi0, Piz, n_topic, n_region, n_location, kernel, location_location, n_doc_zri, n_doc_zr, optimFunc, options, penalty_mu_r)

%% update mu.

%     tic
%     fprintf('maximize Pi0\n');
new_mu = zeros(size(mu));
for r = 1:n_region
%     tic
    func = @(x)negLogLikelihoodMuByRegionFunc(x, r, mu, Pi0, Piz, kernel, location_location, n_topic, n_location, n_doc_zri, n_doc_zr);
    x0 = mu(:,r);
    new_mu(:,r) = optimFunc(func,x0,penalty_mu_r*ones(size(x0)),options);
%     toc
end
mu = new_mu;
clear new_mu;
%     toc

