function [data] = loadData(datasetName, dataPath, varargin)

fprintf('loading data set: %s%s\n', dataPath, datasetName);

%% default input arguments
isUserTweet = true; % indicates to load user_tweet.txt file
isTweetUser = true;

isTweetWord = false;
isTweetLocation = false;
isTweetLocationIndex = false;
isLocationCoordinate = false;
isTweetDailyTime = false;
isTweetWeeklyTime = false;

isUserFollowee = false;
isUserUser = false;
isLocationLocation = false;
isWordWord = false;

%% default data types
isCheckin = false;
isTopic = false;

%% overwrite default data types
for k = 1:2:length(varargin)
    eval([varargin{k}, ' = varargin{', int2str(k + 1), '};']);
end

%% load specific data types
if isCheckin == true
    isTweetLocationIndex = true;
    isLocationCoordinate = true;
    isTweetDailyTime = true;
    isTweetWeeklyTime = true;
    isTweetLocation = true;
    
    isUserUser = true;
    isLocationLocation = true;
end

if isTopic == true
    isTweetWord = true;
    isTweetLocationIndex = true;
    
    isUserUser = true;
    isLocationLocation = true;
    isWordWord = true;
end

%% load data set and save mat files.
dataPath = [dataPath num2str(datasetName)];

%% load user_tweet.txt
if isUserTweet == true
    name = [dataPath '/user_tweet.txt'];
    user_tweet = load(name); user_tweet = spconvert(user_tweet);
    [n_user, n_doc] = size(user_tweet);
    fprintf('user_tweet n_user: %d, n_doc: %d\n', n_user, n_doc);
    
    data.user_tweet = user_tweet;
else
    data.user_tweet = [];
end

%% load tweet_user.txt
if isTweetUser == true
    name = [dataPath '/tweet_user.txt'];
    tweet_user = load(name);
    fprintf('tweet_user n_doc: %d\n', length(tweet_user));
    
    data.tweet_user = tweet_user;
else
    data.tweet_user = [];
end

%% load tweet_word.txt
if isTweetWord == true
    name = [dataPath '/tweet_word.txt'];
    tweet_word = load(name); tweet_word = spconvert(tweet_word);
    [n_doc, n_word] = size(tweet_word);
    fprintf('tweet_word n_doc: %d, n_word: %d\n', n_doc, n_word);
    
    data.tweet_word = tweet_word;
else
    data.tweet_word = [];
end

%% load tweet_location.txt
if isTweetLocation == true
    name = [dataPath '/tweet_location.txt'];
    tweet_location = load(name);
    fprintf('tweet_location n_doc: %d\n', length(tweet_location'));
    
    data.tweet_location = tweet_location;
else
    data.tweet_location = [];
end

%% load tweet_location_index.txt;
if isTweetLocationIndex == true
    name = [dataPath '/tweet_location_index.txt'];
    tweet_location_index = load(name);
    fprintf('tweet_location_index n_doc: %d\n', length(tweet_location_index));
    
    data.tweet_location_index = tweet_location_index;
else
    data.tweet_location_index = [];
end

%% load location_coordinate.txt;
if isLocationCoordinate == true
    name = [dataPath '/location_coordinate.txt'];
    location_coordinate = load(name);
    fprintf('location_coordinate n_location: %d\n', length(location_coordinate));
    
    data.location_coordinate = location_coordinate;
else
    data.location_coordinate = [];
end

%% load tweet_daily_time.txt
if isTweetDailyTime == true
    name = [dataPath '/tweet_daily_time.txt'];
    tweet_daily_time = load(name);
    fprintf('tweet_daily_time n_doc: %d\n', length(tweet_daily_time));
    
    data.tweet_daily_time = tweet_daily_time;
else
    data.tweet_daily_time = [];
end

%% load tweet_weekly_time.txt
if isTweetWeeklyTime == true
    name = [dataPath '/tweet_weekly_time.txt'];
    tweet_weekly_time = load(name);
    fprintf('tweet_weekly_time n_doc: %d\n', length(tweet_weekly_time));
    
    data.tweet_weekly_time = tweet_weekly_time;
else
    data.tweet_weekly_time = [];
end

%% load user_followee.txt
if isUserFollowee == true
    name = [dataPath '/user_followee.txt'];
    user_followee = load(name); user_followee = spconvert(user_followee);
    fprintf('user_followee n_edge: %d\n', length(find(user_followee)));
    
    data.user_followee = user_followee;
else
    data.user_followee = [];
end

%% Original id maps.
if isWordWord == true
    [n_tweet, n_word] = size(tweet_word);
    name = [dataPath '/word_word.txt'];
    [word_word, count_array] = textread(name, '%s %d', n_word);
    fprintf('word_word n_word: %d, count_array n_word: %d\n', length(word_word), length(count_array));
    
    data.word_word = word_word;
else
    data.word_word = [];
end

%% load user_user.txt;
if isUserUser == true
    name = [dataPath '/user_user.txt'];
    [user_user] = textread(name, '%s');
    fprintf('user_user n_user: %d\n', length(user_user));
    
    data.user_user = user_user;
else
    data.user_user = [];
end

%% load location_location.txt;
if isLocationLocation == true
    name = [dataPath '/location_location.txt'];
    location_location = textread(name, '%s');
    fprintf('location_location n_location: %d\n', length(location_location));
    
    data.location_location = location_location;
else
    data.location_location = [];
end





