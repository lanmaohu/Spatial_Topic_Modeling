function [log_epsilon_ir, epsilon_ir] = epsilonForAllRegion(mu, sigma, location_location)

n_location = length(location_location);
[dim, n_region] = size(mu);
log_epsilon_ir = zeros(n_location,n_region);
epsilon_ir = zeros(n_location,n_region);
for r = 1:n_region
    [log_epsilon_i, epsilon_i] = epsilonForARegion(mu, sigma, location_location, r);
    log_epsilon_ir(:,r) = log_epsilon_i;
    epsilon_ir(:,r) = epsilon_i;
end