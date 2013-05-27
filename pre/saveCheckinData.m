function saveCheckinData(datasetName, dataPath, user_tweet, tweet_user, tweet_location_index, location_coordinate, tweet_daily_time, tweet_weekly_time,...
      user_user, location_location)

dataPath = [dataPath num2str(datasetName)];

name = [dataPath '/user_tweet.mat'];
save(name, 'user_tweet');

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