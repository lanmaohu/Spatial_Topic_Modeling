function [f, df] = negLogLikelihoodPw0Func(x, Pwz, n_word, n_topic, n_word_zw, n_word_z)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pw0.
%
% Author:	Bo Hu 2013-01-16
%
% Inputs -----------------------------------------------------------------
% D is the dimension of x.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.

% function value
Pw0 = x;
f = 0;

% derivative value
df = zeros(size(Pw0));

%% precomputation
[sum_wz, log_exp_sum_z, log_gamma_wz, gamma_wz] = gammaForAllTopic(Pw0, Pwz);

% sum_wz = sumPwForAllTopic(Pw0, Pwz);
% exp_sum_wz = exp(sum_wz);
% exp_sum_z = sum(exp_sum_wz)';
% log_exp_sum_z = log(exp_sum_z);

%% compute function value f
for z = 1:n_topic
    % vector version
    f = f + n_word_zw(z,:)*sum_wz(:,z) - n_word_z(z)*log_exp_sum_z(z);
    
%    for w = 1:n_word
%        f = f + n_word_zw(z,w)*sum_wz(w,z);
%    end
%    f = f - n_word_z(z)*log_exp_sum_z(z);
end

%% compute derivative value of function df
for w = 1:n_word
    % vector version
    df(w) = df(w) + sum(n_word_zw(:,w)) - gamma_wz(w,:) * n_word_z;
%     for z = 1:n_topic
%         df(w) = df(w) + n_word_zw(z,w) - n_word_zw(z,w)*(exp_sum_wz(w,z)/exp_sum_z(z));
%     end
end


f = -f;
df = -df;


