function [f] = logLikelihoodPzForRegionAndUserFunc(Pz0, Pzr, Pzu, n_user, n_region, n_doc_zru, n_doc_ru)

% This function returns the function value of the (general dimension) log likelihood function.
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% Pz0, Pzu, n_user, n_topic, n_doc_uz, n_doc_u.
%
% Outputs ----------------------------------------------------------------
% f is function value.


%% function value
f = 0;

%% precomputation
sum_zru = sumPzForAllUserAndAllRegion(Pz0, Pzr, Pzu);
log_exp_sum_ru = log(sum(exp(sum_zru)));

%% compute function value f
for u = 1:n_user
    for r = 1:n_region
        f = f + n_doc_zru(:,r,u)'*sum_zru(:,r,u)- n_doc_ru(r,u)*log_exp_sum_ru(1,r,u);
    end
end

