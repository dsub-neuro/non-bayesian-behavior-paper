%% generates early training monkey data by condition 
% load data file
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey S Motor Exp\pooled_sac_noSac_10DecTo10Jan.mat
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey T Motor Exp\pooled_sac_noSac_14JanTo14Feb.mat

%remember to update the range based on monkey

isJump = cleanData.isJump;
jumpSize = abs(cleanData.jumpSize);
resp =  cleanData.resp;
noNoise = cleanData.noise == 12;
jmpspace = linspace(0, 6, 10000);
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
% 
%Monkey S
baselineSacRange = 1:500;
lowPriorSacRange = 1:500;
highPriorSacRange = 1:500; 

% % Monkey T
% baselineSacRange = 1:350;
% lowPriorSacRange = 1:350;
% highPriorSacRange = 1:350; 
%% 
%set limits and initialization values for psychometric curves
L = [0 0 0 0.6];
U = [1 10 10 1];
st = [0 5 1.2 0.65];

[~, ~, ~, ~, ~, baselineSacBins] = bootstrap_bins_curves_4P(baselineJumpSizeSac(baselineSacRange), baselineRespSac(baselineSacRange), 0.5, 10000, 6, L, U, st);
[baselineAll.min, baselineAll.slope, baselineAll.thresh, baselineAll.max, baselineAll.curve, baselineAll.goodness] = psychCurve_4P(baselineJumpSizeSac(baselineSacRange), baselineRespSac(baselineSacRange), jmpspace, L, U, st);
baselineSacBinsAll = psychCurveBins(baselineJumpSizeSac(baselineSacRange), baselineRespSac(baselineSacRange), 0.5, 6);

[~, ~, ~, ~, ~, lowPriorSacBins] = bootstrap_bins_curves_4P(lowPriorJumpSizeSac(lowPriorSacRange), lowPriorRespSac(lowPriorSacRange), 0.5, 10000, 6, L, U, st);
[lowPriorAll.min, lowPriorAll.slope, lowPriorAll.thresh, lowPriorAll.max, lowPriorAll.curve, lowPriorAll.goodness] = psychCurve_4P(lowPriorJumpSizeSac(lowPriorSacRange), lowPriorRespSac(lowPriorSacRange), jmpspace, L, U, st);
lowPriorSacBinsAll = psychCurveBins(lowPriorJumpSizeSac(lowPriorSacRange), lowPriorRespSac(lowPriorSacRange), 0.5, 6);

[~, ~, ~, ~, ~, highPriorSacBins] = bootstrap_bins_curves_4P(highPriorJumpSizeSac(highPriorSacRange), highPriorRespSac(highPriorSacRange), 0.5, 10000, 6, L, U, st);
[highPriorAll.min, highPriorAll.slope, highPriorAll.thresh, highPriorAll.max, highPriorAll.curve, highPriorAll.goodness] = psychCurve_4P(highPriorJumpSizeSac(highPriorSacRange), highPriorRespSac(highPriorSacRange), jmpspace, L, U, st);
highPriorSacBinsAll = psychCurveBins(highPriorJumpSizeSac(highPriorSacRange), highPriorRespSac(highPriorSacRange), 0.5, 6);


%% cd to save folder
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Motor Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Motor Exp
save('withSaccadeEarlyTraining_curves_intercepts_4P.mat', 'baselineSacBins', 'baselineAll', 'baselineSacBinsAll', 'lowPriorSacBins', 'lowPriorAll', 'lowPriorSacBinsAll', 'highPriorSacBins', 'highPriorAll', 'highPriorSacBinsAll', 'L', 'U', 'st')
