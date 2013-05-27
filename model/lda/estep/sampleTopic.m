function [new_doc_topic] = sampleTopic(tweet_user, tweet_location_index, n_doc,  n_topic, log_alpha_zu, alpha_zu, log_delta_iz, delta_iz)

%% fprintf('sample topic\n');
p_new_doc_topic = zeros(n_topic, n_doc);

%% compute sampling probability
for d = 1:n_doc
    u = tweet_user(d);
    i = tweet_location_index(d);
    
    p_topic = alpha_zu(:,u) .* delta_iz(i,:)'; % p_topic_ui(:,u,i);
    
    p_topic(find(p_topic<realmin)) = realmin;
    p_topic(find(p_topic>realmax)) = realmax;

    p_new_doc_topic(:,d) = p_topic;
end 
new_doc_topic = sampleData(normalize(p_new_doc_topic, 1))';

