%% bootstrap data for prior + noise experiment
load('pooled_clean.mat')

%filter for jumps in saccade direction
inSac = any(cleanData.targLoc < 0, 2) & cleanData.jumpSize < 0 | any(cleanData.targLoc > 0, 2) & cleanData.jumpSize > 0;
% %filter for jumps opposite to saccade direction
% oppSac = any(cleanData.targLoc < 0, 2) & cleanData.jumpSize > 0 | any(cleanData.targLoc > 0, 2) & cleanData.jumpSize <> 0;

%swtich filter based on inSac or oppSac
valid = cleanData.validResp > 0 & inSac; %include early responses
isJump = cleanData.isJump(valid);
jumpSize = cleanData.jumpSize;
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

binSize = 0.5;
jmpspace = linspace(0, 6, 10000);

%% no noise 
%jump size
baselineJS = abs(jumpSize(medPrior & noNoise));
lowPriorNoNoiseJS = abs(jumpSize(lowPrior & noNoise));
highPriorNoNoiseJS = abs(jumpSize(highPrior & noNoise));

%get responses
baselineResp = cleanData.resp(medPrior & noNoise);
lowPriorNoNoiseResp = cleanData.resp(lowPrior & noNoise);
highPriorNoNoiseResp = cleanData.resp(highPrior & noNoise);

[baselineMinAll, ~, ~, ~, baselineCurveAll, ~] = psychCurve_4P(baselineJS, baselineResp, jmpspace);
baselineBinsAll = psychCurveBins(baselineJS, baselineResp, 0.5, 6);
[lowPriorNoNoiseMinAll, ~, ~, ~, lowPriorNoNoiseCurveAll, ~] = psychCurve_4P(lowPriorNoNoiseJS, lowPriorNoNoiseResp, jmpspace);
lowPriorNoNoiseBinsAll = psychCurveBins(lowPriorNoNoiseJS, lowPriorNoNoiseResp, 0.5, 6);
[highPriorNoNoiseMinAll, ~, ~, ~, highPriorNoNoiseCurveAll, ~] = psychCurve_4P(highPriorNoNoiseJS, highPriorNoNoiseResp, jmpspace);
highPriorNoNoiseBinsAll = psychCurveBins(highPriorNoNoiseJS, highPriorNoNoiseResp, 0.5, 6);

%%
cd('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Toki-prior+noise-behaviorOnly\Paper summary data')
save('allData_noNoise.mat', 'baselineCurveAll', 'baselineMinAll', 'baselineBinsAll', 'lowPriorNoNoiseCurveAll', 'lowPriorNoNoiseMinAll', 'lowPriorNoNoiseBinsAll', 'highPriorNoNoiseCurveAll', 'highPriorNoNoiseMinAll', 'highPriorNoNoiseBinsAll');
