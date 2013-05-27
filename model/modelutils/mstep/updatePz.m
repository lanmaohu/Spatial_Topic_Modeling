function [Pz0, Pzu] = updatePz(Pz0, Pzu, n_user, n_topic, n_doc_uz, n_doc_u, optimFunc, options, penalty)

%% update Pz0, Pzu.
func = @(x)negLogLikelihoodPz0Func(x, Pzu, n_user, n_topic, n_doc_uz, n_doc_u);
x0 = Pz0;
Pz0 = optimFunc(func,x0,penalty*ones(size(x0)),options); % efficiency should be fine

new_Pzu = zeros(size(Pzu));
for u = 1:n_user
    func = @(x)negLogLikelihoodPzuByUserFunc(x, u, Pz0, Pzu, n_doc_uz, n_doc_u);
    x0 = Pzu(:,u);
    new_Pzu(:,u) = optimFunc(func,x0,penalty*ones(size(x0)),options);
end
Pzu = new_Pzu;
