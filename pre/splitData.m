function [data_train, data_test] = splitData(data, testRate)

%% cannot choose a word that is in test data but not in training data
trainingTweets = [];
testTweets = [];
[n_user n_doc] = size(data.user_tweet);
for u = 1:n_user
    tweet_index_array = find(data.user_tweet(u,:));
    if length(tweet_index_array) <= 1
        trainingTweets = [trainingTweets tweet_index_array];
    else
        [trainInd,valInd,testInd] = dividerand(tweet_index_array,1-testRate,0.0,testRate);
        if length(trainInd) > length(tweet_index_array) || length(testInd) > length(tweet_index_array)
            fprintf('ERROR: spliting data\n');
        end
        trainingTweets = [trainingTweets trainInd];
        testTweets = [testTweets testInd];
    end
    %     nTest = round(nTweets * testRate);
    %     if nTest < 1 && testRate > 0
    %         nTest = 1;
    %     end
    %     nTrain = nTweets - nTest;
    %     trainingTweets = [trainingTweets tweet_index_array(1:nTrain)];
    %     testTweets = [testTweets tweet_index_array(nTrain+1:nTweets)];
end

%% save tweet_word
if ~isempty(data.tweet_word)
    data_test.tweet_word = data.tweet_word(testTweets,:);
    data_train.tweet_word = data.tweet_word(trainingTweets,:);
    %% train words
    if isempty(find(sum(data_train.tweet_word)==0))
        fprintf('success! number of word %d\n', length(find(sum(data_train.tweet_word)==0)));
    end
else
    data_test.tweet_word = [];
    data_train.tweet_word = [];
end

%% save tweet_user
if ~isempty(data.tweet_user)
    data_test.tweet_user = data.tweet_user(testTweets);
    data_train.tweet_user = data.tweet_user(trainingTweets);
else
    data_test.tweet_user = [];
    data_train.tweet_user = [];
end

%% save tweet_location
if ~isempty(data.tweet_location)
    data_test.tweet_location = data.tweet_location(testTweets,:);
    data_train.tweet_location = data.tweet_location(trainingTweets,:);
else
    data_test.tweet_location = [];
    data_train.tweet_location = [];
end

%% save tweet_daily_time
if ~isempty(data.tweet_daily_time)
    data_test.tweet_daily_time = data.tweet_daily_time(testTweets);
    data_train.tweet_daily_time = data.tweet_daily_time(trainingTweets);
else
    data_test.tweet_daily_time = [];
    data_train.tweet_daily_time = [];
end

%% save tweet_weekly_time
if ~isempty(data.tweet_weekly_time)
    data_test.tweet_weekly_time = data.tweet_weekly_time(testTweets);
    data_train.tweet_weekly_time = data.tweet_weekly_time(trainingTweets);
else
    data_test.tweet_weekly_time = [];
    data_train.tweet_weekly_time = [];
end

%% save tweet_location_index
if ~isempty(data.tweet_location_index)
    data_test.tweet_location_index = data.tweet_location_index(testTweets);
    data_train.tweet_location_index = data.tweet_location_index(trainingTweets);
else
    data_test.tweet_location_index = [];
    data_train.tweet_location_index = [];
end


%% do not split the following data
%% save user_tweet
data_test.user_tweet = data.user_tweet;
data_train.user_tweet = data.user_tweet;

%% save location_coordinate
data_test.location_coordinate = data.location_coordinate;
data_train.location_coordinate = data.location_coordinate;

%% save user_followee
data_test.user_followee = data.user_followee;
data_train.user_followee = data.user_followee;

%% save word_word
data_test.word_word = data.word_word;
data_train.word_word = data.word_word;

%% save user_user
data_test.user_user = data.user_user;
data_train.user_user = data.user_user;

%% save location_location
data_test.location_location = data.location_location;
data_train.location_location = data.location_location;


