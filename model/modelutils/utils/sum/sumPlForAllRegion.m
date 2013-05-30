function [minus_dir, norm_minus_ir] = sumPlForAllRegion(mu, location_location)

[n_location, n_dimension] = size(location_location);
[n_dimension, n_region] = size(mu);

minus_dir = zeros(n_dimension, n_location, n_region);
norm_minus_ir = zeros(n_location, n_region);
for r = 1:n_region
    [minus_di, norm_minus_i] = sumPlForARegion(mu, location_location, r);
    minus_dir(:,:,r) = minus_di;
    norm_minus_ir(:,r) = norm_minus_i;
end
