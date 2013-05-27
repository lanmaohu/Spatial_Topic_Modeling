function [f, df] = negLogLikelihoodPz0ForRegionAndUserFunc(x, Pzr, Pzu, n_region, n_user, n_topic, n_doc_zru, n_doc_ru)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pz0.
%
% Author:	Bo Hu 2013-01-18
%
% Inputs -----------------------------------------------------------------
% D is the dimension of x.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.

%% function value
Pz0 = x;
f = 0;

%% derivative value
df = zeros(size(x));

%% precomputation
[sum_zru, log_exp_sum_ru, log_alpha_zru, alpha_zru] = alphaForAllUserAndAllRegion(Pz0, Pzr, Pzu);

%% compute function value f
% vector version
for u = 1:n_user
    for r = 1:n_region
        f = f + n_doc_zru(:,r,u)'*sum_zru(:,r,u)- n_doc_ru(r,u)*log_exp_sum_ru(1,r,u);
    end
end


%% compute derivative value of function df
% vector version
for z = 1:n_topic
    for r = 1:n_region
        for u = 1:n_user
            df(z) = df(z) + n_doc_zru(z,r,u) - n_doc_ru(r,u) * alpha_zru(z,r,u);
        end
    end
end

% for z = 1:n_topic
%     for u = 1:n_user
%         df(z) = df(z) + n_doc_uz(u,z) - n_doc_u(u) * (exp_sum_zu(z,u)/exp_sum_u(u));
%     end
% end

%% negative
f = -f;
df = -df;



