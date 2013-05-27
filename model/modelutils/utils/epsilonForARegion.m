function [log_epsilon_i, epsilon_i] = epsilonForARegion(mu, sigma, location_location, r)

log_epsilon_i = logmvnpdf(location_location, mu(:,r)', sigma(:,:,r)')';
epsilon_i = exp(log_epsilon_i);

% epsilon_i = gaussPDF(location_location', mu(:,r), sigma(:,:,r));
