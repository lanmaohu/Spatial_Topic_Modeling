function [testData] = splitTestDataForParallel(testData, n_doc, part, nPart)

%% split test data in parallel
testBegin = zeros(nPart, 1);
testEnd = zeros(nPart, 1);

eachPart = n_doc/nPart;
testBegin(1) = 1;
testEnd(1) = testBegin(1) + eachPart;
for i = 2:(nPart-1)
    testBegin(i) = testBegin(i-1) + eachPart + 1;
    testEnd(i) = testBegin(i) + eachPart;
end
testBegin(nPart) =  testBegin(nPart-1) + eachPart + 1;
testEnd(nPart) = n_doc;
testData = testData(testBegin(part):testEnd(part));
