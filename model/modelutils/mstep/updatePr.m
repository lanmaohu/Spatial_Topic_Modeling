function [Pr0, Pru] = updatePr(Pr0, Pru, n_user, n_region, n_doc_ur, n_doc_u, optimFunc, options, penalty_gamma_r0, penalty_gamma_ru, debug)

%% update Pr0, Pru.
if debug
    fprintf('before maximize Prs: %f\n', logLikelihoodPrFunc(Pr0, Pru, n_user, n_doc_ur, n_doc_u));
end

%     tic
%     fprintf('maximize Pr0\n');
func = @(x)negLogLikelihoodPr0Func(x, Pru, n_user, n_region, n_doc_ur, n_doc_u);
x0 = Pr0;
Pr0 = optimFunc(func,x0,penalty_gamma_r0*ones(size(x0)),options);
%     toc

%     tic
%     fprintf('maximize Pru\n');
new_Pru = zeros(size(Pru));
for u = 1:n_user
    func = @(x)negLogLikelihoodPruByUserFunc(x, u, Pr0, Pru, n_doc_ur, n_doc_u);
    x0 = Pru(:,u);
    new_Pru(:,u) = optimFunc(func,x0,penalty_gamma_ru*ones(size(x0)),options);
end
Pru = new_Pru;
clear new_Pru;
%     toc

if debug
    fprintf('after maximize Prs: %f\n', logLikelihoodPrFunc(Pr0, Pru, n_user, n_doc_ur, n_doc_u));
end

