%% load data file
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey S Motor Exp\pooled_sac_noSac_10DecTo10Jan.mat
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey T Motor Exp\pooled_sac_noSac_14JanTo14Feb.mat

%% 
isJump = cleanData.isJump;
jumpSize = abs(cleanData.jumpSize);
resp =  cleanData.resp;
noNoise = cleanData.noise == 12;
jmpspace = linspace(0, 6, 10000);

%limits and initialization values for psychometric curves
L = [0 0 0 0.6];
U = [1 10 10 1];
st = [0 5 1.2 0.65];

%% saccade trials
lowPriorNoNoiseSac = cleanData.thresh == 0.2 & noNoise & cleanData.sacDir > 0;
highPriorNoNoiseSac = cleanData.thresh == 0.8 & noNoise & cleanData.sacDir > 0;
baselineNoNoiseSac = cleanData.thresh == 0.5 & noNoise & cleanData.sacDir > 0;

lowPriorIsJumpSac = isJump(lowPriorNoNoiseSac);
highPriorIsJumpSac = isJump(highPriorNoNoiseSac);
baselineIsJumpSac = isJump(baselineNoNoiseSac);

lowPriorJumpSizeSac = jumpSize(lowPriorNoNoiseSac);
highPriorJumpSizeSac = jumpSize(highPriorNoNoiseSac);
baselineJumpSizeSac = jumpSize(baselineNoNoiseSac);

lowPriorRespSac = resp(lowPriorNoNoiseSac);
highPriorRespSac = resp(highPriorNoNoiseSac);
baselineRespSac = resp(baselineNoNoiseSac);
 
baselineSacRange = length(baselineRespSac) - 1999 : length(baselineRespSac);
highPriorSacRange = length(highPriorRespSac) - 1999 : length(highPriorRespSac);
lowPriorSacRange = length(lowPriorRespSac) - 1999 : length(lowPriorRespSac);

%% 
[baselineSac.min, baselineSac.slope, baselineSac.threshold, baselineSac.max, baselineSac.curves, baselineSac.bins] = bootstrap_bins_curves_4P(baselineJumpSizeSac(baselineSacRange), baselineRespSac(baselineSacRange), 0.5, 10000, 6, L, U, st);
[baselineSacAll.min, baselineSacAll.slope, baselineSacAll.threshold, baselineSacAll.max, baselineSacAll.curve, baselineSacAll.goodness] = psychCurve_4P(baselineJumpSizeSac(baselineSacRange), baselineRespSac(baselineSacRange), jmpspace, L, U, st);
baselineSacAll.bins = psychCurveBins(baselineJumpSizeSac(baselineSacRange), baselineRespSac(baselineSacRange), 0.5, 6);

[lowPriorSac.min, lowPriorSac.slope, lowPriorSac.threshold, lowPriorSac.max, lowPriorSac.curves, lowPriorSac.bins] = bootstrap_bins_curves_4P(lowPriorJumpSizeSac(lowPriorSacRange), lowPriorRespSac(lowPriorSacRange), 0.5, 10000, 6, L, U, st);
[lowPriorSacAll.min, lowPriorSacAll.slope, lowPriorSacAll.threshold, lowPriorSacAll.max, lowPriorSacAll.curve, lowPriorSacAll.goodness] = psychCurve_4P(lowPriorJumpSizeSac(lowPriorSacRange), lowPriorRespSac(lowPriorSacRange), jmpspace, L, U, st);
lowPriorSacAll.bins = psychCurveBins(lowPriorJumpSizeSac(lowPriorSacRange), lowPriorRespSac(lowPriorSacRange), 0.5, 6);

[highPriorSac.min, highPriorSac.slope, highPriorSac.threshold, highPriorSac.max, highPriorSac.curves, highPriorSac.bins] = bootstrap_bins_curves_4P(highPriorJumpSizeSac(highPriorSacRange), highPriorRespSac(highPriorSacRange), 0.5, 10000, 6, L, U, st);
[highPriorSacAll.min, highPriorSacAll.slope, highPriorSacAll.threshold, highPriorSacAll.max, highPriorSacAll.curve, highPriorSacAll.goodness] = psychCurve_4P(highPriorJumpSizeSac(highPriorSacRange), highPriorRespSac(highPriorSacRange), jmpspace, L, U, st);
highPriorSacAll.bins = psychCurveBins(highPriorJumpSizeSac(highPriorSacRange), highPriorRespSac(highPriorSacRange), 0.5, 6);

%cd to save location
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey S Motor Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey T Motor Exp
save('withSaccade_curves_intercepts_4P.mat', 'baselineSac', 'baselineSacAll', 'lowPriorSac', 'lowPriorSacAll', 'highPriorSac', 'highPriorSacAll')

%% no saccade trials
lowPriorNoNoiseNoSac = cleanData.thresh == 0.2 & noNoise & cleanData.sacDir == 0;
highPriorNoNoiseNoSac = cleanData.thresh == 0.8 & noNoise & cleanData.sacDir == 0;
baselineNoNoiseNoSac = cleanData.thresh == 0.5 & noNoise & cleanData.sacDir == 0;

lowPriorIsJumpNoSac = isJump(lowPriorNoNoiseNoSac);
highPriorIsJumpNoSac = isJump(highPriorNoNoiseNoSac);
baselineIsJumpNoSac = isJump(baselineNoNoiseNoSac);

lowPriorJumpSizeNoSac = jumpSize(lowPriorNoNoiseNoSac);
highPriorJumpSizeNoSac = jumpSize(highPriorNoNoiseNoSac);
baselineJumpSizeNoSac = jumpSize(baselineNoNoiseNoSac);

lowPriorRespNoSac = resp(lowPriorNoNoiseNoSac);
highPriorRespNoSac = resp(highPriorNoNoiseNoSac);
baselineRespNoSac = resp(baselineNoNoiseNoSac);

baselineNoSacRange = length(baselineRespNoSac) - 1999 : length(baselineRespNoSac);
highPriorNoSacRange = length(highPriorRespNoSac) - 1999 : length(highPriorRespNoSac);
lowPriorNoSacRange = length(lowPriorRespNoSac) - 1999 : length(lowPriorRespNoSac);

%% 
[baselineNoSac.min, baselineNoSac.slope, baselineNoSac.threshold, baselineNoSac.max, baselineNoSac.curves, baselineNoSac.bins] = bootstrap_bins_curves_4P(baselineJumpSizeNoSac(baselineNoSacRange), baselineRespNoSac(baselineNoSacRange), 0.5, 10000, 6, L, U, st);
[baselineNoSacAll.min, baselineNoSacAll.slope, baselineNoSacAll.threshold, baselineNoSacAll.max, baselineNoSacAll.curve, baselineNoSacAll.goodness] = psychCurve_4P(baselineJumpSizeNoSac(baselineNoSacRange), baselineRespNoSac(baselineNoSacRange), jmpspace, L, U, st);
baselineNoSacAll.bins = psychCurveBins(baselineJumpSizeNoSac(baselineNoSacRange), baselineRespNoSac(baselineNoSacRange), 0.5, 6);

[lowPriorNoSac.min, lowPriorNoSac.slope, lowPriorNoSac.threshold, lowPriorNoSac.max, lowPriorNoSac.curves, lowPriorNoSac.bins] = bootstrap_bins_curves_4P(lowPriorJumpSizeNoSac(lowPriorNoSacRange), lowPriorRespNoSac(lowPriorNoSacRange), 0.5, 10000, 6, L, U, st);
[lowPriorNoSacAll.min, lowPriorNoSacAll.slope, lowPriorNoSacAll.threshold, lowPriorNoSacAll.max, lowPriorNoSacAll.curve, lowPriorNoSacAll.goodness] = psychCurve_4P(lowPriorJumpSizeNoSac(lowPriorNoSacRange), lowPriorRespNoSac(lowPriorNoSacRange), jmpspace, L, U, st);
lowPriorNoSacAll.bins = psychCurveBins(lowPriorJumpSizeNoSac(lowPriorNoSacRange), lowPriorRespNoSac(lowPriorNoSacRange), 0.5, 6);

[highPriorNoSac.min, highPriorNoSac.slope, highPriorNoSac.threshold, highPriorNoSac.max, highPriorNoSac.curves, highPriorNoSac.bins] = bootstrap_bins_curves_4P(highPriorJumpSizeNoSac(highPriorNoSacRange), highPriorRespNoSac(highPriorNoSacRange), 0.5, 10000, 6, L, U, st);
[highPriorNoSacAll.min, highPriorNoSacAll.slope, highPriorNoSacAll.threshold, highPriorNoSacAll.max, highPriorNoSacAll.curve, highPriorNoSacAll.goodness] = psychCurve_4P(highPriorJumpSizeNoSac(highPriorNoSacRange), highPriorRespNoSac(highPriorNoSacRange), jmpspace, L, U, st);
highPriorNoSacAll.bins = psychCurveBins(highPriorJumpSizeNoSac(highPriorNoSacRange), highPriorRespNoSac(highPriorNoSacRange), 0.5, 6);

%cd to save location
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey S Motor Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey T Motor Exp
save('noSaccade_curves_intercepts_4P.mat', 'baselineNoSac', 'baselineNoSacAll', 'lowPriorNoSac', 'lowPriorNoSacAll', 'highPriorNoSac', 'highPriorNoSacAll')
