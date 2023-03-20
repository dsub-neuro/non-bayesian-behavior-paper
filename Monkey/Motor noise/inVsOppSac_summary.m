isJump = cleanData.isJump;
jumpSize = abs(cleanData.jumpSize);
resp =  cleanData.resp;
noNoise = cleanData.noise == 12;
jmpspace = linspace(0, 6, 10000);

L = [0 0 0 0.6];
U = [1 10 10 1];
st = [0 5 1.2 0.65];

%% saccade trials
oppSac = any(cleanData.targLoc < 0, 2) & cleanData.jumpSize > 0 | any(cleanData.targLoc > 0, 2) & cleanData.jumpSize < 0;

lowPriorNoNoiseSac = cleanData.thresh == 0.2 & noNoise & cleanData.sacDir > 0 & oppSac;
highPriorNoNoiseSac = cleanData.thresh == 0.8 & noNoise & cleanData.sacDir > 0 & oppSac;
baselineNoNoiseSac = cleanData.thresh == 0.5 & noNoise & cleanData.sacDir > 0 & oppSac;

lowPriorIsJumpSac = isJump(lowPriorNoNoiseSac);
highPriorIsJumpSac = isJump(highPriorNoNoiseSac);
baselineIsJumpSac = isJump(baselineNoNoiseSac);

lowPriorJumpSizeSac = jumpSize(lowPriorNoNoiseSac);
highPriorJumpSizeSac = jumpSize(highPriorNoNoiseSac);
baselineJumpSizeSac = jumpSize(baselineNoNoiseSac);

lowPriorRespSac = resp(lowPriorNoNoiseSac);
highPriorRespSac = resp(highPriorNoNoiseSac);
baselineRespSac = resp(baselineNoNoiseSac);
 
baselineSacRange = length(baselineRespSac) - 999 : length(baselineRespSac);
highPriorSacRange = length(highPriorRespSac) - 999 : length(highPriorRespSac);
lowPriorSacRange = length(lowPriorRespSac) - 999 : length(lowPriorRespSac);

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

% cd('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Skwiz-dprimeCurve\Paper summary data')
% cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Motor Exp\inVsOppSac')
save('oppSac_curves_intercepts_4P.mat', 'baselineSac', 'baselineSacAll', 'lowPriorSac', 'lowPriorSacAll', 'highPriorSac', 'highPriorSacAll')
% 
