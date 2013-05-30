function [L] = logLikelihood(n_doc_ztu, n_doc_tu, n_doc_ur, n_doc_u, n_doc_zrit, n_doc_zrt, n_region, n_topic, n_user, n_location, n_time,...
    sum_ztu, log_exp_sum_tu, sum_ru, log_exp_sum_r_u, sum_irzt, log_exp_sum_rzt)

% This function returns the function value of the (general dimension) log likelihood function.
%
% Author:	Bo Hu 2013-01-08
%
% Inputs -----------------------------------------------------------------
% Data: user_tweet, tweet_user, tweet_word, tweet_location, tweet_time
% Given parameters: n_user, n_doc, n_word, n_trend, n_region, n_topic, n_time
% Latent variables: doc_region, doc_topic, doc_trend
% Latent parameters: Pz0, Pzr, Pzu, Pw0, Pwr, Pwz, Pr0, Pru, Pc0, Pcu, Pcr,
% Pt0, Ptc, mu, sigma
%
% Outputs ----------------------------------------------------------------
% f is function value.

L = 0;

%% Pz
for u = 1:n_user
    for t = 1:n_time
        L = L + n_doc_ztu(:,t,u)'*sum_ztu(:,t,u)- n_doc_tu(t,u)*log_exp_sum_tu(1,t,u);
    end
end

%% Pr
for u = 1:n_user
    L = L + n_doc_ur(u,:)*sum_ru(:,u) - n_doc_u(u)*log_exp_sum_r_u(u);
end

%% Pi
for t = 1:n_time
    for z = 1:n_topic
        for r = 1:n_region
            L = L + reshape(n_doc_zrit(z,r,:,t),1,n_location) * sum_irzt(:,r,z,t) - n_doc_zrt(z,r,t)*log_exp_sum_rzt(r,z,t);
        end
    end
end

