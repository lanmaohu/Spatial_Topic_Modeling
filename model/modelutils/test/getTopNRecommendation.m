function [indexRank, locationIndexRank] = getTopNRecommendation(lik, topN, n_location, freq_ui, u)

%% sort location
[valueRank, indexRank] = sort(lik, 'descend');
locationIndexRank = zeros(topN,1);
if isempty(freq_ui)
    locationIndexRank = indexRank(1:topN);
else
    n_pred = 0;
    for ind = 1:n_location
        location_ind = indexRank(ind);
        %% already recommend the location or already visited by user in the training data set.
        if freq_ui(u,location_ind) == 0
            n_pred = n_pred + 1;
            locationIndexRank(n_pred) = location_ind;
            %         else
            %             fprintf('location: %d has already been visited by the user\n', location_ind);
        end
        if (n_pred >= topN)
            break;
        end
    end
end