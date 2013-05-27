function [mu, sigma] = updateMuAndSigma(mu, sigma, n_region, tweet_location, doc_region, debug)

%% update mu and sigma.
if debug
    fprintf('before maximize mus: %f\n', logLikelihoodPlFunc(mu, sigma, n_region, tweet_location, doc_region));
end

%     tic
%     fprintf('maximize mu\n');
for r = 1:n_region
    n_doc_region = length(find(doc_region == r));
    % if the cluster has no or only one member, continue.
    if n_doc_region <= 1
        continue;
    end
    % update center
    mu(:,r) = sum(tweet_location(find(doc_region == r),:))/n_doc_region;
    % update covariance
    dist = tweet_location(find(doc_region == r),:) - repmat(mu(:,r)', n_doc_region, 1);
    % if cluster has one member, do not update sigma.
    sigma(:,:,r) = (dist'*dist)/(n_doc_region-1);
    %Add a tiny variance to avoid numerical instability
    sigma(:,:,r) = sigma(:,:,r) + 1E-5.*diag(ones(2,1));
end
%     toc

if debug
    fprintf('after maximize mus: %f\n', logLikelihoodPlFunc(mu, sigma, n_region, tweet_location, doc_region));
end