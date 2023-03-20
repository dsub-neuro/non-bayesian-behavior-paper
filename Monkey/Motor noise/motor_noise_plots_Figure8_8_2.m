%Monkey S
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Motor Exp')
%Monkey T
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Motor Exp')

%% 
load('withSaccade_curves_intercepts_4P.mat')
load('noSaccade_curves_intercepts_4P.mat')

%% for in vs. opp sac
%Monkey S
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Motor Exp\inVsOppSac')
%Monkey T
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Motor Exp\inVsOppSac')

%no saccade same as overall data
%for with saccade:
%in saccade direction
load('inSac_curves_intercepts_4P.mat')
%opposite saccade direction
load('oppSac_curves_intercepts_4P.mat')

%% get error info
%with saccade
withSacDiffMean = highPriorSacAll.min - lowPriorSacAll.min;
withSacDiff = highPriorSac.min - lowPriorSac.min;
withSacDiffCI = prctile(withSacDiff, [2.5 97.5]);

baselineSacBinsCI = prctile(baselineSac.bins, [2.5 97.5]);
lowPriorSacBinsCI = prctile(lowPriorSac.bins, [2.5 97.5]);
highPriorSacBinsCI = prctile(highPriorSac.bins, [2.5 97.5]);

%no saccade
noSacDiffMean = highPriorNoSacAll.min - lowPriorNoSacAll.min;
noSacDiff = highPriorNoSac.min - lowPriorNoSac.min;
noSacDiffCI = prctile(noSacDiff, [2.5 97.5]);

baselineNoSacBinsCI = prctile(baselineNoSac.bins, [2.5 97.5]);
lowPriorNoSacBinsCI = prctile(lowPriorNoSac.bins, [2.5 97.5]);
highPriorNoSacBinsCI = prctile(highPriorNoSac.bins, [2.5 97.5]);

%% plot Min differences. Figure 8f and 8i
figure
errorbar(1:2, [noSacDiffMean, withSacDiffMean], [noSacDiffMean - noSacDiffCI(1), withSacDiffMean - withSacDiffCI(1)], [noSacDiffCI(2) - noSacDiffMean, withSacDiffCI(2) - withSacDiffMean], 'ko', 'LineWidth', 2, 'MarkerSize', 10)
xlim([0.8 2.2])
xticks([1 2])
ylim([-0.1 0.5])
yticks([-0.1 0.1 0.3 0.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none')

%% with sac psychometric curve. Figure 8e and 8h.

jmpspace = linspace(0, 6, 10000);
bins = 0.25:0.5:5.75;

%get error info
lowPriorSacBinsNegError = lowPriorSacAll.bins - lowPriorSacBinsCI(1, :);
lowPriorSacBinsPosError = lowPriorSacBinsCI(2, :) - lowPriorSacAll.bins;

baselineSacBinsNegError = baselineSacAll.bins - baselineSacBinsCI(1, :);
baselineSacBinsPosError = baselineSacBinsCI(2, :) - baselineSacAll.bins;

highPriorSacBinsNegError = highPriorSacAll.bins - highPriorSacBinsCI(1, :);
highPriorSacBinsPosError = highPriorSacBinsCI(2, :) - highPriorSacAll.bins;

%plot curves
figure %with saccade
errorbar(bins, lowPriorSacAll.bins, lowPriorSacBinsNegError, lowPriorSacBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorSacAll.curve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, baselineSacAll.bins, baselineSacBinsNegError, baselineSacBinsPosError, 'o', 'color', [0 0 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, baselineSacAll.curve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, highPriorSacAll.bins, highPriorSacBinsNegError, highPriorSacBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorSacAll.curve, 'color', [1 0.65 0], 'LineWidth', 2)
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% no saccade psychometric curve. Figure 8d and 8g.
lowPriorNoSacBinsNegError = lowPriorNoSacAll.bins - lowPriorNoSacBinsCI(1, :);
lowPriorNoSacBinsPosError = lowPriorNoSacBinsCI(2, :) - lowPriorNoSacAll.bins;

baselineNoSacBinsNegError = baselineNoSacAll.bins - baselineNoSacBinsCI(1, :);
baselineNoSacBinsPosError = baselineNoSacBinsCI(2, :) - baselineNoSacAll.bins;

highPriorNoSacBinsNegError = highPriorNoSacAll.bins - highPriorNoSacBinsCI(1, :);
highPriorNoSacBinsPosError = highPriorNoSacBinsCI(2, :) - highPriorNoSacAll.bins;
%
figure %no saccade
errorbar(bins, lowPriorNoSacAll.bins, lowPriorNoSacBinsNegError, lowPriorNoSacBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorNoSacAll.curve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, baselineNoSacAll.bins, baselineNoSacBinsNegError, baselineNoSacBinsPosError, 'o', 'color', [0 0 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, baselineNoSacAll.curve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, highPriorNoSacAll.bins, highPriorNoSacBinsNegError, highPriorNoSacBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorNoSacAll.curve, 'color', [1 0.65 0], 'LineWidth', 2)
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')