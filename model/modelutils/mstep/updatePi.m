function [Pi0, Piz] = updatePi(Pi0, Piz, n_topic, n_location, n_doc_zi, n_doc_z, optimFunc, options, penalty)

%% update Pi0, Piz.
func = @(x)negLogLikelihoodPi0Func(x, Piz, n_topic, n_location, n_doc_zi, n_doc_z);
x0 = Pi0;
Pi0 = optimFunc(func,x0,penalty*ones(size(x0)),options);

new_Piz = zeros(size(Piz));
for z = 1:n_topic
    func = @(x)negLogLikelihoodPizByTopicFunc(x, z, Pi0, Piz, n_doc_zi, n_doc_z);
    x0 = Piz(:,z);
    new_Piz(:,z) = optimFunc(func,x0,penalty*ones(size(x0)),options);
end
Piz = new_Piz;
