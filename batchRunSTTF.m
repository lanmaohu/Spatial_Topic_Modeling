%% clear variables and paths.
clear;
restoredefaultpath;

%% add data
dataPath = './data/';
datasetName = 'Brightkite_NYC_u1_v5'; % Phoenix NYC Brightkite_NYC_u1_v5 Gowalla_NYC_u1_v5

%% batch run
modelName = 'sttf';
addpath(strcat('./model/', modelName));
% for training
isTrain = true;
n_topic_array = [20];
n_region_array = [20];
n_time = 24;
kernel = 100;
penalty = 1;
% for test
isTest = true;
isRevisit = 1;
topN = 20;

for i = 1:length(n_topic_array)
    for j = 1:length(n_region_array)
        
        %% parameter
        n_topic = n_topic_array(i);
        n_region = n_region_array(j);
        
        %% output directory 'model + para'
        outputDir = strcat('./exp/', datasetName, '/', modelName, '_', 'z', num2str(n_topic), '_', 'r', num2str(n_region), '_', 't', num2str(n_time), '_', 'k', num2str(kernel), '_', 'p', num2str(penalty));
        mkdir(outputDir);
        
        %% train
        if isTrain == true
            fprintf('training data: %s\n', datasetName);
            data_train = load(strcat(dataPath, datasetName, '/data_train.mat'));
            [para, iterStat] = STTF(data_train, n_topic, n_region, n_time, kernel, penalty);
            save(strcat(outputDir, '/para.mat'), '-struct', 'para');
            save(strcat(outputDir, '/iterStat.mat'), '-struct', 'iterStat');
        end
        
        %% test
        if isTest == true
            freq_ui = [];
            if isRevisit == 0
                data_train = load(strcat(dataPath, datasetName, '/data_train.mat'));
                addpath('./utils');
                [freq_ui] = getUserLocation(data_train.user_tweet, data_train.tweet_user, data_train.location_coordinate, data_train.tweet_location_index);
            end
            
            fprintf('testing data: %s\n', datasetName);
            data_test = load(strcat(dataPath, datasetName, '/data_test.mat'));
            para = load(strcat(outputDir, '/para.mat'));
            [res] = testSTTF(data_test, n_topic, n_region, n_time, kernel, para, 'isRevisit', isRevisit, 'freq_ui', freq_ui, 'topN', topN);
            save(strcat(outputDir, '/res.mat'), '-struct', 'res');
        end 
    end
end


