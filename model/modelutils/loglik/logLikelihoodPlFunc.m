function [f] = logLikelihoodPlFunc(mu, sigma, n_region, tweet_location, doc_region)

f = 0;
for r = 1:n_region
    f = f + sum(logmvnpdf(tweet_location(doc_region==r,:), mu(:,r)', sigma(:,:,r)')); % potential bugs because gaussPDF return 0 probability.
end


%f = 0;
%for r = 1:n_region
%    f = f + sum(log(gaussPDF(tweet_location(doc_region==r,:)', mu(:,r), sigma(:,:,r)))); % potential bugs because gaussPDF return 0 probability.
%end