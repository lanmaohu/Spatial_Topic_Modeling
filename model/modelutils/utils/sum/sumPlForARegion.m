function [minus_di, norm_minus_i] = sumPlForARegion(mu, location_location, r)

[n_location, n_dimension] = size(location_location);

norm_minus_i = zeros(n_location, 1);
minus_di = repmat(mu(:,r),1,n_location) - location_location';
for i = 1:n_location
    norm_minus_i(i) = norm( minus_di(:,i) ,2 );
end

