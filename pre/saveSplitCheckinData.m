function saveSplitCheckinData(datasetName, dataPath, tweet_user_train, tweet_user_test, tweet_daily_time_train, tweet_daily_time_test, tweet_weekly_time_train, tweet_weekly_time_test,...
    tweet_location_index_train, tweet_location_index_test)

%% save train and test data set
dataPath = [dataPath num2str(datasetName)];

name = [dataPath '/tweet_user_train.mat'];
save(name, 'tweet_user_train');
name = [dataPath '/tweet_user_test.mat'];
save(name, 'tweet_user_test');

name = [dataPath '/tweet_location_index_train.mat'];
save(name, 'tweet_location_index_train');
name = [dataPath '/tweet_location_index_test.mat'];
save(name, 'tweet_location_index_test');

name = [dataPath '/tweet_daily_time_train.mat'];
save(name, 'tweet_daily_time_train');
name = [dataPath '/tweet_daily_time_test.mat'];
save(name, 'tweet_daily_time_test');

name = [dataPath '/tweet_weekly_time_train.mat'];
save(name, 'tweet_weekly_time_train');
name = [dataPath '/tweet_weekly_time_test.mat'];
save(name, 'tweet_weekly_time_test');