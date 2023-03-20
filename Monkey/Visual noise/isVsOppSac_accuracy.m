%% bootstrap data for prior + noise experiment
load('pooled_clean.mat')

%% in direction of saccade
%filter for jumps in saccade direction
inSac = any(cleanData.targLoc < 0, 2) & cleanData.jumpSize < 0 | any(cleanData.targLoc > 0, 2) & cleanData.jumpSize > 0;

%swtich filter based on inSac or oppSac
valid = cleanData.validResp > 0 & inSac; %include early responses

isJump = cleanData.isJump(valid);
resp =  cleanData.resp(valid);
noise = cleanData.noise(valid);
color = cleanData.color(valid, :);
thresh = cleanData.thresh(valid);

colorInd = NaN(length(resp), 1);
%get low and high prior colors
highPriorThresh = thresh == 0.8;
highPriorColor = color(highPriorThresh, :);
highPriorColor = highPriorColor(1, :);

lowPriorThresh = thresh == 0.2;
lowPriorColor = color(lowPriorThresh, :);
lowPriorColor = lowPriorColor(1, :);

for ii = 1:length(colorInd)
    if color(ii, :) == highPriorColor
        colorInd(ii) = 3;
    elseif color(ii, :) == lowPriorColor
        colorInd(ii) = 2;
    else
        colorInd(ii) = 1;
    end
end

medPrior = colorInd == 1;
lowPrior = colorInd == 2;
highPrior = colorInd == 3;

noiselevels = unique(noise);
noNoise = noise == noiselevels(1);
lowNoise = noise == noiselevels(2);
highNoise = noise == noiselevels(3);

baselineResp = resp(medPrior & noNoise);
baselineIsJump = isJump(medPrior & noNoise);

isCorrect = baselineIsJump == 1 & baselineResp == 1 | baselineIsJump == 0 & baselineResp == 0;
inSacData.acc = sum(isCorrect)/length(isCorrect);

inSacData.CI = bootci(10000, @getAccuracy, isCorrect);

%% 
%filter for jumps opposite to saccade direction
oppSac = any(cleanData.targLoc < 0, 2) & cleanData.jumpSize > 0 | any(cleanData.targLoc > 0, 2) & cleanData.jumpSize < 0;
%swtich filter based on inSac or oppSac
valid = cleanData.validResp > 0 & oppSac; %include early responses

isJump = cleanData.isJump(valid);
resp =  cleanData.resp(valid);
noise = cleanData.noise(valid);
color = cleanData.color(valid, :);
thresh = cleanData.thresh(valid);

colorInd = NaN(length(resp), 1);
%get low and high prior colors
highPriorThresh = thresh == 0.8;
highPriorColor = color(highPriorThresh, :);
highPriorColor = highPriorColor(1, :);

lowPriorThresh = thresh == 0.2;
lowPriorColor = color(lowPriorThresh, :);
lowPriorColor = lowPriorColor(1, :);

for ii = 1:length(colorInd)
    if color(ii, :) == highPriorColor
        colorInd(ii) = 3;
    elseif color(ii, :) == lowPriorColor
        colorInd(ii) = 2;
    else
        colorInd(ii) = 1;
    end
end

medPrior = colorInd == 1;
lowPrior = colorInd == 2;
highPrior = colorInd == 3;

noiselevels = unique(noise);
noNoise = noise == noiselevels(1);
lowNoise = noise == noiselevels(2);
highNoise = noise == noiselevels(3);

baselineResp = resp(medPrior & noNoise);
baselineIsJump = isJump(medPrior & noNoise);

isCorrect = baselineIsJump == 1 & baselineResp == 1 | baselineIsJump == 0 & baselineResp == 0;
oppSacData.acc = sum(isCorrect)/length(isCorrect);

oppSacData.CI = bootci(10000, @getAccuracy, isCorrect);

%% 
function acc = getAccuracy(isCorrect)
    acc = sum(isCorrect)/length(isCorrect);
end
