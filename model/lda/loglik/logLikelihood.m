function [L] = logLikelihood(n_doc_uz, n_doc_u, n_doc_zi, n_doc_z, n_topic, n_user, para)

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




L = logLikelihoodPzFunc(para.Pz0, para.Pzu, n_user, n_doc_uz, n_doc_u)...
    + logLikelihoodPiFunc(para.Pi0, para.Piz, n_topic, n_doc_zi, n_doc_z);
