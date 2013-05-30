function [para] = initParameters(data, varargin)

%% default input arguments
n_topic = 0;
n_region = 0;
n_time = 0;
n_trend = 0;

%% overwrite default input arguments
for k = 1:2:length(varargin)
    eval([varargin{k}, ' = varargin{', int2str(k + 1), '};']);
end

%% sizes of data
[n_user, n_all_doc] = size(data.user_tweet);
[n_doc] = length(data.tweet_user);




%% not using sparse matrix for parameters!!!

%% init topic related parameters
if n_topic > 0
    para.Pz0 = zeros(n_topic,1); % background topic distribution
    para.Pzu = zeros(n_topic,n_user); % user specific topic distribution
    
    if ~isempty(data.tweet_word) % init word related parameters
        [n_doc, n_word] = size(data.tweet_word);
        freq_w = sum(data.tweet_word)';
        freq_w(find(freq_w~=0)) = log(freq_w(find(freq_w~=0)));
        para.Pw0 = full(freq_w); % background word distribution --- log frequency
        para.Pwz = zeros(n_word, n_topic); % topic specific word distribution
    end
    
    if ~isempty(data.tweet_location_index) % init location related parameters 
        n_location = length(data.location_location);
        para.Pi0 = zeros(n_location, 1); % background location distribution --- log frequency
        for i = 1:n_location
            freq_i = length(find(data.tweet_location_index==i));
            if freq_i > 0
                para.Pi0(i) = log(freq_i);
            else
                para.Pi0(i) = 0;
            end
        end
        para.Piz = zeros(n_location, n_topic);
    end
end

%% init region related parameters
if n_region > 0
    if ~isempty(data.tweet_location)
        [priors0, mu0, sigma0] = EM_init_kmeans(data.tweet_location', n_region); % cluster locations using kmeans.
        para.mu0 = mu0;
        para.sigma0 = sigma0;
        para.mu = mu0;
        para.sigma = sigma0;
        
        para.Pr0 = priors0'; % Pr0 initializes as importance of regions.
        para.Pru = zeros(n_region, n_user);
%         p_doc_region = zeros(n_doc, n_region);
%         for r = 1:n_region
%             p_doc_region(:,r) = gaussPDF(tweet_location', mu(:,r), sigma(:,:,r))';
%         end
%         [value, index] = sort(p_doc_region, 2, 'descend');
%         para.doc_region = index(:,1);
    end
    
%     if ~isempty(data.tweet_word)
%         para.Pwr = zeros(n_word, n_region); % fprintf('initial Pwr\n');
%         freq_r_w = zeros(n_region, n_word);
%         for r = 1:n_region
%             freq_r_w(r,:) = sum(data.tweet_word(find(para.doc_region==r),:));
%         end
%         tmpPw0 = repmat(Pw0', n_region, 1);
%         freq_r_w(find(freq_r_w~=0)) = log(freq_r_w(find(freq_r_w~=0))) - tmpPw0(find(freq_r_w~=0));
%         freq_r_w(find(freq_r_w==0)) = - tmpPw0(find(freq_r_w==0));
%         
%         para.Pwr = freq_r_w';
%     end
end

%% init daily time related parameters
if n_time > 0
    if ~isempty(data.tweet_location_index) % init daily time related parameters
        para.Pit = zeros(n_location, n_time);
    end
    if n_topic > 0 % init daily time related parameters
        para.Pzt = zeros(n_topic, n_time);
    end
end

