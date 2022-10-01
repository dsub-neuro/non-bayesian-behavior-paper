function yBins = psychCurveBins(jumpSize, response, binSize, maxJump)
%returns the probability of responding jumped given a jump size as the
%proportion of trials on which subjects responded "jumped" for specified bin
%sizes. 
if ~(length(jumpSize) == length(response))
    error('The jumpSize and response vectors must be the same length')
elseif ~(rem(maxJump, binSize) == 0)
    error('maxJump must be an integer multiple of binSize')
end

jumpSize(jumpSize > maxJump) = maxJump; %set the upper limit on jump sizes

jsBins = NaN(1, maxJump/binSize);
respBins = NaN(1, maxJump/binSize);

binStart = 0;
binIndex = 1;

while binIndex <= length(jsBins)
    js = intersect(find(jumpSize >= binStart), find(jumpSize < (binStart + binSize)));
    jsBins(binIndex) = length(js);
    
    resp = find(response(js) == 1);
    respBins(binIndex) = length(resp);
    
    binIndex = binIndex +1;
    binStart = binStart + binSize;
end

yBins = respBins./jsBins; 

end