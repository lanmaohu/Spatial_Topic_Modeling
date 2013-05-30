function [mu] = updateMuForSTTF(mu, Pi0, Piz, Pit, n_topic, n_region, n_location, n_time, kernel, location_coordinate, n_doc_zrit, n_doc_zrt, optimFunc, options, penalty_mu_r)

%% update mu.
new_mu = zeros(size(mu));
for r = 1:n_region
    func = @(x)negLogLikelihoodMuByRegionFuncForSTTF(x, r, mu, Pi0, Piz, Pit, kernel, location_coordinate, n_topic, n_location, n_time, n_doc_zrit, n_doc_zrt);
    x0 = mu(:,r);
%     options.verbose = 1;
    new_mu(:,r) = optimFunc(func,x0,penalty_mu_r*ones(size(x0)),options);
end
mu = new_mu;

