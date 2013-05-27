function [para, iterStat] = LDA(data, n_topic, penalty, varargin)

%% stats of input data---------------------------------------------------------------
[n_user, n_all_doc] = size(data.user_tweet);
n_location = length(data.location_coordinate);
n_doc = length(data.tweet_user);

fprintf('doc count: %d\n', n_doc);
fprintf('user count: %d\n', n_user);
fprintf('location count: %d\n', n_location);

%% stats of input parameters
fprintf('topic count: %d\n', n_topic);
fprintf('penalty: %d\n', penalty);

%% add utils
addpath('./utils'); % utility functions
addpath(genpath('./model/lda')); % model functions
addpath(genpath('./model/modelutils')); % model utility functions

%% init para
[para] = initParameters(data, 'n_topic', n_topic);

%% overwrite default data types
for k = 1:2:length(varargin)
    eval([varargin{k}, ' = varargin{', int2str(k + 1), '};']);
end

%% iteration stats
iter = 0;
loglik_threshold = 1e-4;
maxiter = 500;
loglikArray = [];
loglik_old = -realmax;

%% maximization options---------------------------------------------------------------
addpath(genpath('../L1General')); % l1 regularization optimization lib
optimFunc = @L1General2_PSSgb; %@L1GeneralIteratedRidge; % @L1GeneralCompositeGradientAccelerated;
options.corrections = 10; % Number of corrections to store for L-BFGS methods
options.optTol = 1e-4; % tolarance
options.verbose = 0; % display iteration

%% iteration.
while iter <= maxiter
    tic % whole iteration

    %% e-step, sample latent variables.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% precomputation. sum up all latent variable Ps.
    [sum_zu, log_exp_sum_u, log_alpha_zu, alpha_zu] = alphaForAllUser(para.Pz0, para.Pzu);
    [sum_iz, log_exp_sum_z, log_delta_iz, delta_iz] = deltaForAllTopic(para.Pi0, para.Piz);


    %sample region matrix : doc_region
    doc_topic = sampleTopic(data.tweet_user, data.tweet_location_index, n_doc, n_topic, log_alpha_zu, alpha_zu, log_delta_iz, delta_iz);
    
    
    %% precomputation, in order to get doc_region, doc_topic and tweet_user, tweet_location_index stats.
    [n_doc_uz, n_doc_u] = countDocForUserAndTopic(n_user, n_topic, doc_topic, data.tweet_user);
    [n_doc_zi, n_doc_z] = countDocForTopicAndLocation(n_topic, n_location, doc_topic, data.tweet_location_index);
    
    %% check out whether converged, and compute the log likelihood.
    loglik = logLikelihood(n_doc_uz, n_doc_u, n_doc_zi, n_doc_z, n_topic, n_user, para);
    
    loglikArray = [loglikArray loglik];
    fprintf('iteration: %d, %f, %f\n', iter, loglik, abs((loglik/loglik_old)-1));
    
    %stop the process depending on the increase of the log likelihood
    if abs((loglik/loglik_old)-1) < loglik_threshold
        break;
    end
    loglik_old = loglik;

    
    %% m-step, maximize log likelihood with respect to parameters.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% update Pi0, Piz.
    [para.Pi0, para.Piz] = updatePi(para.Pi0, para.Piz, n_topic, n_location, n_doc_zi, n_doc_z, optimFunc, options, penalty);

	%% update Pz0, Pzu.
    [para.Pz0, para.Pzu] = updatePz(para.Pz0, para.Pzu, n_user, n_topic, n_doc_uz, n_doc_u, optimFunc, options, penalty);
   
    toc % whole iteration
end

iterStat.loglikArray = loglikArray;














