%% get data by condition for the visual experiment
%cd to appropriate folder for each monkey
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Visual Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Visual Exp
%% bootstrap data for prior + noise experiment
load('pooled_clean.mat')
valid = cleanData.validResp > 0; %include early responses
isJump = cleanData.isJump(valid);
jumpSize = abs(cleanData.jumpSize);
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
L = [0 0 0 0.6];
U = [1 10 10 1];
st = [0 5 1.2 0.65];


%% no noise 
%jump size
baselineJS = jumpSize(medPrior & noNoise);
lowPriorNoNoiseJS = jumpSize(lowPrior & noNoise);
highPriorNoNoiseJS = jumpSize(highPrior & noNoise);

%get responses
baselineResp = cleanData.resp(medPrior & noNoise);
lowPriorNoNoiseResp = cleanData.resp(lowPrior & noNoise);
highPriorNoNoiseResp = cleanData.resp(highPrior & noNoise);

% no noise bootstrapped curves, bins and intercepts
[baseline.min, baseline.slope, baseline.threshold, baseline.max, baseline.curves, baseline.bins] = bootstrap_bins_curves_4P(baselineJS, baselineResp, 0.5, 10000, 6, L, U, st);
[lowPriorNoNoise.min, lowPriorNoNoise.slope, lowPriorNoNoise.threshold, lowPriorNoNoise.max, lowPriorNoNoise.curves, lowPriorNoNoise.bins] = bootstrap_bins_curves_4P(lowPriorNoNoiseJS, lowPriorNoNoiseResp, 0.5, 10000, 6, L, U, st);
[highPriorNoNoise.min, highPriorNoNoise.slope, highPriorNoNoise.threshold, highPriorNoNoise.max, highPriorNoNoise.curves, highPriorNoNoise.bins] = bootstrap_bins_curves_4P(highPriorNoNoiseJS, highPriorNoNoiseResp, 0.5, 10000, 6, L, U, st);

%bins and curves for all the data 
[baselineAll.min, baselineAll.slope, baselineAll.threshold, baselineAll.max, baselineAll.curve, baselineAll.goodness] = psychCurve_4P(baselineJS, baselineResp, jmpspace, L, U, st);
baselineAll.bins = psychCurveBins(baselineJS, baselineResp, 0.5, 6);
[lowPriorNoNoiseAll.min, lowPriorNoNoiseAll.slope, lowPriorNoNoiseAll.threshold, lowPriorNoNoiseAll.max, lowPriorNoNoiseAll.curve, lowPriorNoNoiseAll.goodness] = psychCurve_4P(lowPriorNoNoiseJS, lowPriorNoNoiseResp, jmpspace, L, U, st);
lowPriorNoNoiseAll.bins = psychCurveBins(lowPriorNoNoiseJS, lowPriorNoNoiseResp, 0.5, 6);
[highPriorNoNoiseAll.min, highPriorNoNoiseAll.slope, highPriorNoNoiseAll.threshold, highPriorNoNoiseAll.max, highPriorNoNoiseAll.curve, highPriorNoNoiseAll.goodness] = psychCurve_4P(highPriorNoNoiseJS, highPriorNoNoiseResp, jmpspace, L, U, st);
highPriorNoNoiseAll.bins = psychCurveBins(highPriorNoNoiseJS, highPriorNoNoiseResp, 0.5, 6);

% cd to save location. 
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Visual Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Visual Exp
save('prior_noNoise_Bootstrap.mat', 'binSize', 'baseline', 'baselineAll', 'lowPriorNoNoise', 'lowPriorNoNoiseAll', 'highPriorNoNoise', 'highPriorNoNoiseAll', 'L', 'U', 'st')

%% low and high noise data had discretized jump sizes, so confidence intervals bootstrapped at each jump size
%low noise
%low prior
lowPriorLowNoiseJS = abs(jumpSize(lowPrior & lowNoise));
lowPriorLowNoiseResp = cleanData.resp(lowPrior & lowNoise);
[lowPriorLowNoiseAll.min, lowPriorLowNoiseAll.slope, lowPriorLowNoiseAll.threshold, lowPriorLowNoiseAll.max, lowPriorLowNoiseAll.curve, lowPriorLowNoiseAll.goodness] = psychCurve_4P(lowPriorLowNoiseJS, lowPriorLowNoiseResp, jmpspace, L, U, st);

jumpSizes = unique(lowPriorLowNoiseJS);

lowPriorLowNoiseCI = NaN(2, length(jumpSizes));
lowPriorLowNoiseMean = NaN(1, length(jumpSizes));

for js = 1:length(jumpSizes)
    currInd = find(lowPriorLowNoiseJS == jumpSizes(js));
    if jumpSizes(js) == 0
        lowPriorLowNoiseZeroResp = lowPriorLowNoiseResp(currInd);
    end    
    lowPriorLowNoiseMean(js) = mean(lowPriorLowNoiseResp(currInd));
    if length(lowPriorLowNoiseResp(currInd)) > 1
        lowPriorLowNoiseCI(:, js) = bootci(10000, @mean, lowPriorLowNoiseResp(currInd));
    else
        lowPriorLowNoiseCI(:, js) = mean(lowPriorLowNoiseResp(currInd));
    end
end

%high prior
highPriorLowNoiseJS = abs(jumpSize(highPrior & lowNoise));
highPriorLowNoiseResp = cleanData.resp(highPrior & lowNoise);
[highPriorLowNoiseAll.min, highPriorLowNoiseAll.slope, highPriorLowNoiseAll.threshold, highPriorLowNoiseAll.max, highPriorLowNoiseAll.curve, highPriorLowNoiseAll.goodness] = psychCurve_4P(highPriorLowNoiseJS, highPriorLowNoiseResp, jmpspace, L, U, st);

highPriorLowNoiseCI = NaN(2, length(jumpSizes));
highPriorLowNoiseMean = NaN(1, length(jumpSizes));

for js = 1:length(jumpSizes)
    currInd = find(highPriorLowNoiseJS == jumpSizes(js));
    if jumpSizes(js) == 0
        highPriorLowNoiseZeroResp = highPriorLowNoiseResp(currInd);
    end  
    highPriorLowNoiseMean(js) = mean(highPriorLowNoiseResp(currInd));
    if length(highPriorLowNoiseResp(currInd)) > 1
        highPriorLowNoiseCI(:, js) = bootci(10000, @mean, highPriorLowNoiseResp(currInd));
    else
        highPriorLowNoiseCI(:, js) = mean(highPriorLowNoiseResp(currInd));
    end
end

%  high noise 
%low prior 
lowPriorHighNoiseJS = abs(jumpSize(lowPrior & highNoise));
lowPriorHighNoiseResp = cleanData.resp(lowPrior & highNoise);
[lowPriorHighNoiseAll.min, lowPriorHighNoiseAll.slope, lowPriorHighNoiseAll.threshold, lowPriorHighNoiseAll.max, lowPriorHighNoiseAll.curve, lowPriorHighNoiseAll.goodness] = psychCurve_4P(lowPriorHighNoiseJS, lowPriorHighNoiseResp, jmpspace, L, U, st);

lowPriorHighNoiseCI = NaN(2, length(jumpSizes));
lowPriorHighNoiseMean = NaN(1, length(jumpSizes));

for js = 1:length(jumpSizes)
    currInd = find(lowPriorHighNoiseJS == jumpSizes(js));
    if jumpSizes(js) == 0
        lowPriorHighNoiseZeroResp = lowPriorHighNoiseResp(currInd);
    end
    lowPriorHighNoiseMean(js) = mean(lowPriorHighNoiseResp(currInd));
    if length(lowPriorHighNoiseResp(currInd)) > 1
        lowPriorHighNoiseCI(:, js) = bootci(10000, @mean, lowPriorHighNoiseResp(currInd));
    else
        lowPriorHighNoiseCI(:, js) = mean(lowPriorHighNoiseResp(currInd));
    end
end

%high prior
highPriorHighNoiseJS = abs(jumpSize(highPrior & highNoise));
highPriorHighNoiseResp = cleanData.resp(highPrior & highNoise);
[highPriorHighNoiseAll.min, highPriorHighNoiseAll.slope, highPriorHighNoiseAll.threshold, highPriorHighNoiseAll.max, highPriorHighNoiseAll.curve, highPriorHighNoiseAll.goodness] = psychCurve_4P(highPriorHighNoiseJS, highPriorHighNoiseResp, jmpspace, L, U, st);

highPriorHighNoiseCI = NaN(2, length(jumpSizes));
highPriorHighNoiseMean = NaN(1, length(jumpSizes));

for js = 1:length(jumpSizes)
    currInd = find(highPriorHighNoiseJS == jumpSizes(js));
    if jumpSizes(js) == 0
        highPriorHighNoiseZeroResp = highPriorHighNoiseResp(currInd);
    end
    highPriorHighNoiseMean(js) = mean(highPriorHighNoiseResp(currInd));
    if length(highPriorHighNoiseResp(currInd)) > 1
        highPriorHighNoiseCI(:, js) = bootci(10000, @mean, highPriorHighNoiseResp(currInd));
    else
        highPriorHighNoiseCI(:, js) = mean(highPriorHighNoiseResp(currInd));
    end
end

% cd to save location. 
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Visual Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Visual Exp
save('prior_lowAndHighNoise_bootstrap.mat', 'jumpSizes', 'lowPriorLowNoiseMean', 'lowPriorLowNoiseCI', 'lowPriorLowNoiseAll', 'lowPriorLowNoiseZeroResp', 'highPriorLowNoiseMean', 'highPriorLowNoiseCI', 'highPriorLowNoiseAll', 'highPriorLowNoiseZeroResp', 'lowPriorHighNoiseMean', 'lowPriorHighNoiseCI', 'lowPriorHighNoiseAll', 'lowPriorHighNoiseZeroResp', 'highPriorHighNoiseMean', 'highPriorHighNoiseCI', 'highPriorHighNoiseAll', 'highPriorHighNoiseZeroResp')
