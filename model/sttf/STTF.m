function [para, iterStat] = STTF(data, n_topic, n_region, n_time, kernel, penalty, varargin)

%% Inputs -----------------------------------------------------------------
% user_tweet : user_tweet matrix (observed data)
%              user_tweet(i,j) stores whether tweet j authored by user i
% tweet_user : tweet_user matrix (observed data)
%              tweet_user(i,j) stores whether tweet i authored by user j
% tweet_word : tweet_word matrix (observed data)
%              tweet_word(i,j) stores number of occurrences of word j in tweet i
% tweet_location : tweet_location matrix (observed data)
%                   tweet_location(i, :) stores the lat/log of tweet i
% tweet_location_index : tweet_location_index matrix (observed data)
%                   tweet_location_index(i, :) stores the location index of tweet i
% n_region : # of regions
% n_topic : # of topics
% alpha, beta, gamma, delta : hyperparameters
%
%
%% Outputs ----------------------------------------------------------------
% priors : importance weights of regions
% mu : means of regions
% sigma : covariance matrix of regions
% Pz0 : topic distributions for background
% Pzu : topic distributions for users
% Pw0 : word distributions for background
% Pwz : word distributions for topics
% Pr0 : region distributions for background
% Pru : region distributions for users
% Pi0 : location distributions for background
% Piz : location distributions for topics

%% model name
modelName = 'sttf';

%% stats of input data---------------------------------------------------------------
[n_user, n_all_doc] = size(data.user_tweet);
n_location = length(data.location_coordinate);
n_doc = length(data.tweet_user);

fprintf('training: %s\n', modelName);
fprintf('doc count: %d\n', n_doc);
fprintf('user count: %d\n', n_user);
fprintf('location count: %d\n', n_location);

%% stats of input parameters
fprintf('topic count: %d\n', n_topic);
fprintf('region count: %d\n', n_region);
fprintf('n_time count: %d\n', n_time);
fprintf('kernel: %d\n', kernel);
fprintf('penalty: %d\n', penalty);

%% define tweet_time
if n_time == 24
    data.tweet_time = data.tweet_daily_time;
end
if n_time == 7
    data.tweet_time = data.tweet_weekly_time;
end

%% add utils
addpath('./utils'); % utility functions
addpath(genpath(strcat('./model/', modelName))); % model functions
addpath(genpath('./model/modelutils')); % model utility functions

%% init para
[para] = initParameters(data, 'n_topic', n_topic, 'n_region', n_region, 'n_time', n_time);
doc_topic = randi(n_topic, n_doc, 1);

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
addpath(genpath('./lib/L1General')); % l1 regularization optimization lib
optimFunc = @L1General2_PSSgb; %@L1GeneralIteratedRidge; % @L1GeneralCompositeGradientAccelerated;
options.corrections = 10; % Number of corrections to store for L-BFGS methods
options.optTol = 1e-4; % tolarance
options.verbose = 0; % display iteration
options.maxIter = 10; % max iteration

%% iteration.
while iter <= maxiter
    tic % whole iteration
    
   %% e-step, sample latent variables.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% precomputation. sum up all latent variable Ps.
    [sum_ztu, log_exp_sum_tu, log_alpha_ztu, alpha_ztu] = alphaForAllUserAndAllTime(para.Pz0, para.Pzt, para.Pzu);
    [sum_ru, log_exp_sum_r_u, log_beta_ru, beta_ru] = betaForAllUser(para.Pr0, para.Pru);
    [sum_irzt, log_exp_sum_rzt, log_delta_irzt, delta_irzt] = deltaForAllTopicForAllTimeForAllRegion(para.Pi0, para.Piz, para.Pit, kernel, para.mu, data.location_coordinate);

    %% sample region matrix : doc_region
    doc_region = sampleRegion(data.tweet_user, data.tweet_location_index, data.tweet_time, doc_topic, n_doc, n_region, beta_ru, delta_irzt);
    
    %% sample topic matrix : doc_topic
    doc_topic = sampleTopic(data.tweet_user, data.tweet_location_index, data.tweet_time, doc_region, n_doc, n_topic, alpha_ztu, delta_irzt);

    %% precomputation, in order to get doc_region, doc_topic and tweet_user, tweet_location_index stats.
    [n_doc_ztu, n_doc_tu] = countDocForTimeAndUserAndTopic(n_user, n_topic, n_time, doc_topic, data.tweet_user, data.tweet_time);
    [n_doc_ur, n_doc_u] = countDocForUserAndRegion(n_user, n_region, doc_region, data.tweet_user);
    [n_doc_zrit, n_doc_zrt] = countDocForTopicAndRegionAndLocationAndTime(n_topic, n_region, n_location, n_time, doc_topic, doc_region, data.tweet_location_index, data.tweet_time);
    
    %% check out whether converged, and compute the log likelihood.
    loglik = logLikelihood(n_doc_ztu, n_doc_tu, n_doc_ur, n_doc_u, n_doc_zrit, n_doc_zrt, n_region, n_topic, n_user, n_location, n_time,...
        sum_ztu, log_exp_sum_tu, sum_ru, log_exp_sum_r_u, sum_irzt, log_exp_sum_rzt);

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
    
    %% update mu and sigma.
    [para.mu] = updateMuForSTTF(para.mu, para.Pi0, para.Piz, para.Pit, n_topic, n_region, n_location, n_time, kernel, data.location_coordinate, n_doc_zrit, n_doc_zrt, optimFunc, options, penalty);
    
    %% update Pi0, Piz.
    [para.Pi0, para.Piz, para.Pit] = updatePiForSTTF(para.Pi0, para.Piz, para.Pit, kernel, para.mu, data.location_coordinate, n_topic, n_region, n_location, n_time, n_doc_zrit, n_doc_zrt, optimFunc, options, penalty);

    %% update Pr0, Pru.
    [para.Pr0, para.Pru] = updatePr(para.Pr0, para.Pru, n_user, n_region, n_doc_ur, n_doc_u, optimFunc, options, penalty);
    
    %% update Pz0, Pzu, Pzt.
    [para.Pz0, para.Pzt, para.Pzu] = updatePzForTimeAndUser(para.Pz0, para.Pzt, para.Pzu, n_user, n_time, n_doc_ztu, n_doc_tu, optimFunc, options, penalty);
    
%     %% save current iteration.
%     name = [outputDir 'iter_'];
%     name = [name num2str(iter)];
%     save(name);
%     
%     %% delete last iteration
%     name = [outputDir 'iter_'];
%     name = [name num2str(iter-1)];
%     name = [name '.mat'];
%     delete(name);
    
    iter = iter + 1;

    toc % whole iteration
end

iterStat.loglikArray = loglikArray;
















