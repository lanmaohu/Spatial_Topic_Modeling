%% clear variables and paths.
clear;
restoredefaultpath;

%% add data
dataPath = './data/';
datasetName = 'Brightkite_NYC_u1_v5'; % Phoenix NYC Brightkite_NYC_u1_v5 Gowalla_NYC_u1_v5
addpath(strcat(dataPath, datasetName));

%% batch run
modelName = 'lda';
addpath(strcat('./model/', modelName));
n_topic_array = [10];
penalty = 1;
isTrain = false;
isTest = true;
isRevisit = 1;

for i = 1:length(n_topic_array)
    %% parameter
    n_topic = n_topic_array(i);
    
    %% output directory 'model + para'
    outputDir = strcat('./exp/', datasetName, '/', modelName, '_', 'z', num2str(n_topic), '_', 'p', num2str(penalty));
    mkdir(outputDir);
    
    %% train
    if isTrain == true
        data_train = load('data_train.mat');
        [para, iterStat] = LDA(data_train, n_topic, penalty);
        save(strcat(outputDir, '/para.mat'), '-struct', 'para');
        save(strcat(outputDir, '/iterStat.mat'), '-struct', 'iterStat');
    end
    
    %% test
    if isTest == true
        freq_ui = [];
        if isRevisit == 0
            data_train = load('data_train.mat');
            addpath('./utils');
            [freq_ui] = getUserLocation(data_train.user_tweet, data_train.tweet_user, data_train.location_coordinate, data_train.tweet_location_index);
        end
        
        data_test = load('data_test');
        para = load(strcat(outputDir, '/para.mat'));
        [res] = testLDA(freq_ui, data_test, n_topic, para, outputDir);
        save(strcat(outputDir, '/res.mat'), '-struct', 'res');
    end
end


