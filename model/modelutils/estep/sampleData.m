function sample = sampleData(ProbData)
%
% This function samples index based on the probability of index.
%
% Author:	Bo Hu 2013-01-07
%
% Inputs -----------------------------------------------------------------
%   o ProbData:  D x N array representing N datapoints of D index, 
%        ProbData(i, j) stores the probability of index i in data j.
%
% Outputs ----------------------------------------------------------------
%   o sample:  1 x N array representing the index sample for the 
%            N datapoints.     

[nIndex, nData] = size(ProbData);
for i = 2:nIndex
    ProbData(i,:) = ProbData(i,:) + ProbData(i-1,:);
end
randomThreshold = rand(1,nData);
sample = zeros(1,nData);
for j = 1:nIndex
    sample( intersect(find(randomThreshold<=ProbData(j,:)), find(sample==0)) ) = j;
end

% if (~isempty(find(sample==0)))
%     pause;
% end