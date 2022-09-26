load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_allTrials_4P.mat')
load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_pooledCurves_4P.mat')
%%
bins = 0.125:0.25:4;
n = size(baselinePsychBins, 1);
%% 
figure %no noise
jmpspace = linspace(0, 4, 10000);
%baseline
errorbar(bins, nanmean(baselinePsychBins), nanstd(baselinePsychBins)/sqrt(n), 'ko', 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, baselineCurve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, nanmean(lowPriorNoNoisePsychBins), nanstd(lowPriorNoNoisePsychBins)/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorNoNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, nanmean(highPriorNoNoisePsychBins), nanstd(highPriorNoNoisePsychBins)/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorNoNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
%% low noise

figure
errorbar(bins, nanmean(lowPriorLowNoisePsychBins), nanstd(lowPriorLowNoisePsychBins)/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorLowNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, nanmean(highPriorLowNoisePsychBins), nanstd(highPriorLowNoisePsychBins)/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorLowNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% high noise

figure
errorbar(bins, nanmean(lowPriorHighNoisePsychBins), nanstd(lowPriorHighNoisePsychBins)/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorHighNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, nanmean(highPriorHighNoisePsychBins), nanstd(highPriorHighNoisePsychBins)/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorHighNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
