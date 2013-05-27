function saveData(datasetName, dataPath, data)

dataPath = [dataPath num2str(datasetName)];

%% save all data field
dataFieldNames = fieldnames(data); 
for i = 1:length(dataFieldNames)
    field = data.(dataFieldNames{i});
    name = [dataPath '/'];
    name = [name dataFieldNames{i}];
    save(name, field);
end

save('newstruct.mat', '-struct', 'S')

name = [dataPath '/tweet_user.mat'];
save(name, 'tweet_user');

name = [dataPath '/tweet_location_index.mat'];
save(name, 'tweet_location_index');

name = [dataPath '/location_coordinate.mat'];
save(name, 'location_coordinate');

name = [dataPath '/tweet_daily_time.mat'];
save(name, 'tweet_daily_time');

name = [dataPath '/tweet_weekly_time.mat'];
save(name, 'tweet_weekly_time');

name = [dataPath '/user_user.mat'];
save(name, 'user_user');

name = [dataPath '/location_location.mat'];
save(name, 'location_location');


%% save data set
name = [dataPath '/user_tweet.mat'];
save(name, 'user_tweet');
name = [dataPath '/tweet_user.mat'];
save(name, 'tweet_user');
name = [dataPath '/tweet_word.mat'];
save(name, 'tweet_word');
name = [dataPath '/tweet_location.mat'];
save(name, 'tweet_location');
name = [dataPath '/tweet_location_index.mat'];
save(name, 'tweet_location_index');
name = [dataPath '/location_coordinate.mat'];
save(name, 'location_coordinate');
name = [dataPath '/tweet_daily_time.mat'];
save(name, 'tweet_daily_time');
name = [dataPath '/tweet_weekly_time.mat'];
save(name, 'tweet_weekly_time');
name = [dataPath '/user_followee.mat'];
save(name, 'user_followee');
name = [dataPath '/word_array.mat'];
save(name, 'word_array');
name = [dataPath '/count_array.mat'];
save(name, 'count_array');
name = [dataPath '/user_user.mat'];
save(name, 'user_user');
name = [dataPath '/location_location.mat'];
save(name, 'location_location');