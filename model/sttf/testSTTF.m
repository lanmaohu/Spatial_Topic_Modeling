function [res] = testSTTF(data,n_topic, n_region, n_time, kernel, para, varargin)

%% stats of input data---------------------------------------------------------------
[n_user, n_all_doc] = size(data.user_tweet);
n_location = length(data.location_coordinate);
n_doc = length(data.tweet_user);

fprintf('testing STT\n');
fprintf('doc count: %d\n', n_doc);
fprintf('user count: %d\n', n_user);
fprintf('location count: %d\n', n_location);

%% define tweet_time
if n_time == 24
    data.tweet_time = data.tweet_daily_time;
end
if n_time == 7
    data.tweet_time = data.tweet_weekly_time;
end

%% stats of input parameters
fprintf('topic count: %d\n', n_topic);
fprintf('region count: %d\n', n_region);
fprintf('time count: %d\n', n_time);
fprintf('kernel count: %d\n', kernel);
    
%% add utils
addpath('./utils'); % utility functions
addpath(genpath('./model/modelutils')); % model utility functions

%% init
isRevisit = true;
freq_ui = [];
topN = 20;

%% overwrite default data types
for k = 1:2:length(varargin)
    eval([varargin{k}, ' = varargin{', int2str(k + 1), '};']);
end

%% precomputation
[sum_ztu, log_exp_sum_tu, log_alpha_ztu, alpha_ztu] = alphaForAllUserAndAllTime(para.Pz0, para.Pzt, para.Pzu);
[sum_ru, log_exp_sum_r_u, log_beta_ru, beta_ru] = betaForAllUser(para.Pr0, para.Pru);
[sum_irz, log_exp_sum_rz, log_delta_irz, delta_irz] = deltaForAllTopicForAllRegion(para.Pi0, para.Piz, kernel, para.mu, data.location_coordinate);

%% average distance error
aveDistError = 0;
avePrecision = zeros(5,1);
perplexity = 0;

%% test every record
%% test every record, given its user and predict and recommend locations.
for d = 1:n_doc
    u = data.tweet_user(d);
    i = data.tweet_location_index(d);
    l = data.tweet_location(d,:);
    t = data.tweet_time(d);
    if abs(l(1)-data.location_coordinate(i,1)) > 0.001 || abs(l(2)-data.location_coordinate(i,2)) > 0.001 
        fprintf('error location is not consistent\n');  
    end
    
    %% likelihood
    lik = zeros(n_location, 1);
    for z = 1:n_topic
        for r = 1:n_region
            lik = lik + alpha_ztu(z,t,u) * beta_ru(r,u) * delta_irz(:, r, z);
        end
    end
    lik = normalize(lik); % should be normalized to compute perplexity.
    
    %% sort location
    [valueRank, locationIndexRank] = getTopNRecommendation(lik, topN, n_location, isRevisit, freq_ui, u);
    
    %% perplexity
    if lik(i) == 0
        perplexity = perplexity + log(realmin);    
    else
        perplexity = perplexity + log(lik(i));
    end    
    
    %% location prediction
    predL = data.location_coordinate(locationIndexRank(1),:);
    error = kilometerDistance(predL(1), predL(2), l(1), l(2)); % in kilometer distance
    aveDistError = aveDistError + error;
    
    %% location recommendation
    locationRank = find(locationIndexRank == i);
    if (locationRank <= 1)
        avePrecision(1) = avePrecision(1) + 1;
    end
    if (locationRank <= 5)
        avePrecision(2) = avePrecision(2) + 1/5;
    end
    if (locationRank <= 10)
        avePrecision(3) = avePrecision(3) + 1/10;
    end
    if (locationRank <= 15)
        avePrecision(4) = avePrecision(4) + 1/15;
    end
    if (locationRank <= 20)
        avePrecision(5) = avePrecision(5) + 1/20;
    end
    
%     tmpAveDistError = aveDistError/j;
%     tmpAvePrecition = avePrecision/j;
%     tmpPerplexity = exp(-perplexity/j);
% %     fprintf('doc: %d, error: %f, ave: %f, ave precision: %f %f %f %f %f, perplexity: %f\n', j, error, tmpAveDistError, tmpAvePrecition(1), tmpAvePrecition(2), tmpAvePrecition(3), tmpAvePrecition(4), tmpAvePrecition(5), tmpPerplexity);    
%     fprintf(fout, 'doc: %d, error: %f, ave: %f, ave precision: %f %f %f %f %f, perplexity: %f\n', j, error, tmpAveDistError, tmpAvePrecition(1), tmpAvePrecition(2), tmpAvePrecition(3), tmpAvePrecition(4), tmpAvePrecition(5), tmpPerplexity);    
end
% fclose(fout);

%% results
res.aveDistError = aveDistError/n_doc;
res.perplexity = exp(-perplexity/n_doc);
res.avePrecision = avePrecision/n_doc;

fprintf('%f\n', res.aveDistError);
fprintf('%f\n', res.perplexity);
fprintf('%f\n', res.avePrecision(1));
fprintf('%f\n', res.avePrecision(2));
fprintf('%f\n', res.avePrecision(3));
fprintf('%f\n', res.avePrecision(4));
fprintf('%f\n', res.avePrecision(5));