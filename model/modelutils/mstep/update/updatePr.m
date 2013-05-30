function [Pr0, Pru] = updatePr(Pr0, Pru, n_user, n_region, n_doc_ur, n_doc_u, optimFunc, options, penalty)

%% update Pr0, Pru.
func = @(x)negLogLikelihoodPr0Func(x, Pru, n_user, n_region, n_doc_ur, n_doc_u);
x0 = Pr0;
Pr0 = optimFunc(func,x0,penalty*ones(size(x0)),options);

new_Pru = zeros(size(Pru));
for u = 1:n_user
    func = @(x)negLogLikelihoodPruByUserFunc(x, u, Pr0, Pru, n_doc_ur, n_doc_u);
    x0 = Pru(:,u);
    new_Pru(:,u) = optimFunc(func,x0,penalty*ones(size(x0)),options);
end
Pru = new_Pru;

