function [min, slope, threshold, max, curves, bins] = bootstrap_bins_curves_4P(jumpSize, resp, binSize, bootsamplesize, maxJump, curveL, curveU, curveST)
%B = table with intercept and slope columns
min = NaN(bootsamplesize, 1);
slope = NaN(bootsamplesize, 1);
threshold = NaN(bootsamplesize, 1);
max = NaN(bootsamplesize, 1);
curves = NaN(bootsamplesize, 10000);
binEdges = 0:binSize:maxJump;
bins = NaN(bootsamplesize, length(binEdges) - 1);
jumpSize = abs(jumpSize);
jmpspace = linspace(0, maxJump, 10000);
for ii = 1:bootsamplesize
    data = datasample(1:length(jumpSize), length(jumpSize));
    currJumpSize = jumpSize(data);
    currResp = resp(data);
    jumpBins = discretize(currJumpSize, binEdges);
    for binNum = 1:(length(binEdges) - 1)
        currBin = jumpBins == binNum;
        bins(ii, binNum) = nanmean(currResp(currBin));
    end
    [min(ii), slope(ii), threshold(ii), max(ii), curves(ii, :), ~] = psychCurve_4P(currJumpSize, currResp, jmpspace, curveL, curveU, curveST);
end
end