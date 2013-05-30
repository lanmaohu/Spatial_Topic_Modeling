function [Pi0, Piz, Pit] = updatePiForSTTF(Pi0, Piz, Pit, kernel, mu, location_coordinate, n_topic, n_region, n_location, n_time, n_doc_zrit, n_doc_zrt, optimFunc, options, penalty)

%% update Pi0, Piz.
func = @(x)negLogLikelihoodPi0ForSTTFFunc(x, Piz, Pit, kernel, mu, location_coordinate, n_topic, n_region, n_location, n_time, n_doc_zrit, n_doc_zrt);
x0 = Pi0;
options.verbose = 1;
Pi0 = optimFunc(func,x0,penalty*ones(size(x0)),options);

new_Piz = zeros(size(Piz));
for z = 1:n_topic
    func = @(x)negLogLikelihoodPizByTopicForSTTFFunc(x, z, Pi0, Piz, Pit, kernel, mu, location_coordinate, n_region, n_location, n_time, n_doc_zrit, n_doc_zrt);
    x0 = Piz(:,z);
    options.verbose = 1;
    new_Piz(:,z) = optimFunc(func,x0,penalty*ones(size(x0)),options);
end
Piz = new_Piz;

new_Pit = zeros(size(Pit));
for t = 1:n_time
    func = @(x)negLogLikelihoodPitByTimeForSTTFFunc(x, t, Pi0, Piz, Pit, kernel, mu, location_coordinate, n_topic, n_region, n_location, n_doc_zrit, n_doc_zrt);
    x0 = Pit(:,t);
    new_Pit(:,t) = optimFunc(func,x0,penalty*ones(size(x0)),options);
end
Pit = new_Pit;


