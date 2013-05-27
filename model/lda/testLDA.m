function [res] = testLDA(freq_ui, data, n_topic, para, outputDir, varargin)

%% stats of input data---------------------------------------------------------------
[n_user, n_all_doc] = size(data.user_tweet);
n_location = length(data.location_coordinate);
n_doc = length(data.tweet_user);

fprintf('doc count: %d\n', n_doc);
fprintf('user count: %d\n', n_user);
fprintf('location count: %d\n', n_location);

%% stats of input parameters
fprintf('topic count: %d\n', n_topic);
    
%% add utils
addpath('./utils'); % utility functions
addpath(genpath('./model/modelutils')); % model utility functions

%% overwrite default data types
for k = 1:2:length(varargin)
    eval([varargin{k}, ' = varargin{', int2str(k + 1), '};']);
end

%% precomputation
[sum_zu, log_exp_sum_u, log_alpha_zu, alpha_zu] = alphaForAllUser(para.Pz0, para.Pzu); % alpha
[sum_iz, log_exp_sum_z, log_delta_iz, delta_iz] = deltaForAllTopic(para.Pi0, para.Piz); % delta

%% perplexity 
perplexity_iu = delta_iz * alpha_zu;
perplexity_iu = normalize(perplexity_iu,1);

%% preparation
fout = fopen(strcat(outputDir, 'test.txt'),'w');
aveDistError = 0;
avePrecision = zeros(5,1);
perplexity = 0;
topN = 20;

%% predict location 
pred_iu = zeros(topN,n_user);
for u = 1:n_user
    [indexRank, locationIndexRank] = getTopNRecommendation(perplexity_iu(:,u), topN, n_location, freq_ui, u);
    pred_iu(:,u) = locationIndexRank;
end

%% test every record, given its user and predict and recommend locations.
for d = 1:n_doc
    u = data.tweet_user(d);
    i = data.tweet_location_index(d);
    l = data.tweet_location(d,:);
    if l ~= data.location_coordinate(i,:);
        fprintf('error location is not consistent\n');  
    end
    
    %% perplexity
    perplexity = perplexity + log(perplexity_iu(i,u));
  
    %% location prediction
    locationIndexRank = pred_iu(:,u);
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
    
    tmpAveDistError = aveDistError/d;
    tmpAvePrecition = avePrecision/d;
    tmpPerplexity = exp(-perplexity/d);
%     fprintf('doc: %d, error: %f, ave: %f, ave precision: %f %f %f %f %f, perplexity: %f\n', d, error, tmpAveDistError, tmpAvePrecition(1), tmpAvePrecition(2), tmpAvePrecition(3), tmpAvePrecition(4), tmpAvePrecition(5), tmpPerplexity);    
    fprintf(fout, 'doc: %d, error: %f, ave: %f, ave precision: %f %f %f %f %f, perplexity: %f\n', d, error, tmpAveDistError, tmpAvePrecition(1), tmpAvePrecition(2), tmpAvePrecition(3), tmpAvePrecition(4), tmpAvePrecition(5), tmpPerplexity);    
end
fclose(fout);

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
