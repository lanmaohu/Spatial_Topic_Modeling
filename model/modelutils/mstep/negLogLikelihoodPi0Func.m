function [f, df] = negLogLikelihoodPi0Func(x, Piz, n_topic, n_location, n_doc_zi, n_doc_z)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pr0.
%
% Author:	Bo Hu 2013-04-10
%
% Inputs -----------------------------------------------------------------
% x, Piz, n_topic, n_location, n_doc_iz, n_doc_z.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.


%% function value
Pi0 = x;
f = 0;

%% derivative value
df = zeros(size(Pi0));

%% precomputation
[sum_iz, log_exp_sum_z, log_delta_iz, delta_iz] = deltaForAllTopic(Pi0, Piz);
 
%% compute function value f
for z = 1:n_topic
   f = f + n_doc_zi(z,:)*sum_iz(:,z) - n_doc_z(z)*log_exp_sum_z(z);
end

%% compute derivative value of function df
for i = 1:n_location

%     for z = 1:n_topic
%         df(i) = df(i) + n_doc_zi(z,i) - n_doc_z(z) * (exp_sum_iz(i,z)/exp_sum_z(z));
%     end
    
    % vector version
    df(i) = df(i) + sum(n_doc_zi(:,i)) - delta_iz(i,:) * n_doc_z;
end

%% negative
f = -f;
df = -df;

