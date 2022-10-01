%% generates the monkey early training plots in Figures 9a (Monkey S) and 9b (Monkey T)

%% load data appropriately for each monkey
% %Monkey S
% cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Motor Exp')
% %Monkey T
% cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Motor Exp')

load('withSaccadeEarlyTraining_curves_intercepts_4P.mat')
%% plot
%get error info
baselineSacBinsCI = prctile(baselineSacBins, [2.5 97.5]);
lowPriorSacBinsCI = prctile(lowPriorSacBins, [2.5 97.5]);
highPriorSacBinsCI = prctile(highPriorSacBins, [2.5 97.5]);

lowPriorSacBinsNegError = lowPriorSacBinsAll - lowPriorSacBinsCI(1, :);
lowPriorSacBinsPosError = lowPriorSacBinsCI(2, :) - lowPriorSacBinsAll;

baselineSacBinsNegError = baselineSacBinsAll - baselineSacBinsCI(1, :);
baselineSacBinsPosError = baselineSacBinsCI(2, :) - baselineSacBinsAll;

highPriorSacBinsNegError = highPriorSacBinsAll - highPriorSacBinsCI(1, :);
highPriorSacBinsPosError = highPriorSacBinsCI(2, :) - highPriorSacBinsAll;

jmpspace = linspace(0, 6, 10000);
bins = 0.25:0.5:5.75;

%plot curves
figure %with saccade
errorbar(bins, lowPriorSacBinsAll, lowPriorSacBinsNegError, lowPriorSacBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorAll.curve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, baselineSacBinsAll, baselineSacBinsNegError, baselineSacBinsPosError, 'o', 'color', [0 0 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, baselineAll.curve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, highPriorSacBinsAll, highPriorSacBinsNegError, highPriorSacBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorAll.curve, 'color', [1 0.65 0], 'LineWidth', 2)
ylim([0 1])
xlim([0 3])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
