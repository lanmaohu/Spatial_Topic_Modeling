function [f, df] = negLogLikelihoodPz0ForTimeAndUserFunc(x, Pzt, Pzu, n_time, n_user, n_doc_ztu, n_doc_tu)

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
[sum_ztu, log_exp_sum_tu, log_alpha_ztu, alpha_ztu] = alphaForAllUserAndAllTime(Pz0, Pzt, Pzu);

%% compute function value f
% vector version
for u = 1:n_user
    for t = 1:n_time
        f = f + n_doc_ztu(:,t,u)'*sum_ztu(:,t,u)- n_doc_tu(t,u)*log_exp_sum_tu(1,t,u);
    end
end


%% compute derivative value of function df
% vector version
for t = 1:n_time
    for u = 1:n_user
        df(:) = df(:) + n_doc_ztu(:,t,u) - n_doc_tu(t,u) * alpha_ztu(:,t,u);
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



