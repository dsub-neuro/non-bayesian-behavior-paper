function yBins = psychCurveBins_nonBinary(jumpSize, response, binSize, maxJump)
%returns the probability of responding jumped given a jump size as the
%ratio of trials on which subjects responded "jumped" for specified bin
%sizes. 
if ~(length(jumpSize) == length(response))
    error('The jumpSize and response vectors must be the same length')
elseif ~(rem(maxJump, binSize) == 0)
    error('maxJump must be an integer multiple of binSize')
end

jumpSize(jumpSize > maxJump) = maxJump; %set the upper limit on jump sizes

yBins = NaN(1, maxJump/binSize);

binStart = 0;
binIndex = 1;

while binIndex <= length(yBins)
    %find indices for jumps within the bin
    js = intersect(find(jumpSize >= binStart), find(jumpSize < (binStart + binSize)));
    
    yBins(binIndex) = nanmean((response(js)));

    binIndex = binIndex +1;
    binStart = binStart + binSize;
end

end