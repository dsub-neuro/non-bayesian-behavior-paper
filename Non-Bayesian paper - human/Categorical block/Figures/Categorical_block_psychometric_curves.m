load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_allTrials2.mat')
bins = 0:0.25:3.75;
n = size(baselinePsychBins, 1);

%% plots
figure %no noise
jmpspace = linspace(0, 4, 10000);
%baseline
errorbar(bins, nanmean(baselinePsychBins), nanstd(baselinePsychBins)/sqrt(n), 'ko', 'MarkerSize', 8, 'LineWidth', 1)
hold on
meanBaselineCurve =  nanmean(baselinePsychCurves); %mean of rows excluding NaNs (averages along first dimension with more than one value by default, in this case rows which are the first dimension)
seBaselineCurve = nanstd(baselinePsychCurves)./sqrt(20); %standard deviation across rows divided by the square root of the number of rows
%psychometric curves
shadedErrorBar(jmpspace, meanBaselineCurve, seBaselineCurve, 'lineProps', 'k')
hold on
%low prior
errorbar(bins, nanmean(lowPriorNoNoisePsychBins), nanstd(lowPriorNoNoisePsychBins)/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
meanLowPriorNoNoiseCurve =  nanmean(lowPriorNoNoisePsychCurves); %mean of rows excluding NaNs (averages along first dimension with more than one value by default, in this case rows which are the first dimension)
seLowPriorNoNoiseCurve = nanstd(lowPriorNoNoisePsychCurves)./sqrt(20); %standard deviation across rows divided by the square root of the number of rows
%psychometric curves
shadedErrorBar(jmpspace, meanLowPriorNoNoiseCurve, seLowPriorNoNoiseCurve, 'lineProps', 'b')
hold on
%high prior
errorbar(bins, nanmean(highPriorNoNoisePsychBins), nanstd(highPriorNoNoisePsychBins)/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
meanHighPriorNoNoiseCurve =  nanmean(highPriorNoNoisePsychCurves); %mean of rows excluding NaNs (averages along first dimension with more than one value by default, in this case rows which are the first dimension)
seHighPriorNoNoiseCurve = nanstd(highPriorNoNoisePsychCurves)./sqrt(20); %standard deviation across rows divided by the square root of the number of rows
%psychometric curves
shadedErrorBar(jmpspace, meanHighPriorNoNoiseCurve, seHighPriorNoNoiseCurve, 'lineProps', 'r')
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)

%%
figure %low noise
meanLowPriorLowNoiseCurve =  nanmean(lowPriorLowNoisePsychCurves); %mean of rows excluding NaNs (averages along first dimension with more than one value by default, in this case rows which are the first dimension)
seLowPriorLowNoiseCurve = nanstd(lowPriorLowNoisePsychCurves)./sqrt(20); %standard deviation across rows divided by the square root of the number of rows
%psychometric curves
errorbar(bins, nanmean(lowPriorLowNoisePsychBins), nanstd(lowPriorLowNoisePsychBins)/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(jmpspace, meanLowPriorLowNoiseCurve, seLowPriorLowNoiseCurve, 'lineProps', 'b')
hold on
meanHighPriorLowNoiseCurve =  nanmean(highPriorLowNoisePsychCurves); %mean of rows excluding NaNs (averages along first dimension with more than one value by default, in this case rows which are the first dimension)
seHighPriorLowNoiseCurve = nanstd(highPriorLowNoisePsychCurves)./sqrt(20); %standard deviation across rows divided by the square root of the number of rows
%psychometric curves
errorbar(bins, nanmean(highPriorLowNoisePsychBins), nanstd(highPriorLowNoisePsychBins)/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(jmpspace, meanHighPriorLowNoiseCurve, seHighPriorLowNoiseCurve, 'lineProps', 'r')
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)

%% 
figure %high noise
meanLowPriorHighNoiseCurve =  nanmean(lowPriorHighNoisePsychCurves); %mean of rows excluding NaNs (averages along first dimension with more than one value by default, in this case rows which are the first dimension)
seLowPriorHighNoiseCurve = nanstd(lowPriorHighNoisePsychCurves)./sqrt(20); %standard deviation across rows divided by the square root of the number of rows
%psychometric curves
errorbar(bins, nanmean(lowPriorHighNoisePsychBins), nanstd(lowPriorHighNoisePsychBins)/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(jmpspace, meanLowPriorHighNoiseCurve, seLowPriorHighNoiseCurve, 'lineProps', 'b')
hold on
meanHighPriorHighNoiseCurve =  nanmean(highPriorHighNoisePsychCurves); %mean of rows excluding NaNs (averages along first dimension with more than one value by default, in this case rows which are the first dimension)
seHighPriorHighNoiseCurve = nanstd(highPriorHighNoisePsychCurves)./sqrt(20); %standard deviation across rows divided by the square root of the number of rows
%psychometric curves
errorbar(bins, nanmean(highPriorHighNoisePsychBins), nanstd(highPriorHighNoisePsychBins)/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(jmpspace, meanHighPriorHighNoiseCurve, seHighPriorHighNoiseCurve, 'lineProps', 'r')
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
