%generates the no-noise ("low noise" in manuscript) psychometric curve
%plots in the visual noise experiment. 
%Figures 7a and 7b.
%% load summarized data from appropriate folder for each monkey
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Visual Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Visual Exp

load('prior_noNoise_bootstrap.mat')

%% get errors for bins
%baseline
baselineBinsCI = prctile(baseline.bins, [2.5 97.5]);

%low prior
lowPriorNoNoiseBinsCI = prctile(lowPriorNoNoise.bins, [2.5 97.5]);

%high prior
highPriorNoNoiseBinsCI = prctile(highPriorNoNoise.bins, [2.5 97.5]);

%% plot psychometric curves
jmpspace = linspace(0, 6, 10000);
bins = 0.25:0.5:5.75;

lowPriorNoNoiseBinsNegError = lowPriorNoNoiseAll.bins - lowPriorNoNoiseBinsCI(1, :);
lowPriorNoNoiseBinsPosError = lowPriorNoNoiseBinsCI(2, :) - lowPriorNoNoiseAll.bins;

baselineBinsNegError = baselineAll.bins - baselineBinsCI(1, :);
baselineBinsPosError = baselineBinsCI(2, :) - baselineAll.bins;

highPriorNoNoiseBinsNegError = highPriorNoNoiseAll.bins - highPriorNoNoiseBinsCI(1, :);
highPriorNoNoiseBinsPosError = highPriorNoNoiseBinsCI(2, :) - highPriorNoNoiseAll.bins;

%% 
errorbar(bins, lowPriorNoNoiseAll.bins, lowPriorNoNoiseBinsNegError, lowPriorNoNoiseBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorNoNoiseAll.curve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, baselineAll.bins, baselineBinsNegError, baselineBinsPosError, 'o', 'color', [0 0 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, baselineAll.curve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, highPriorNoNoiseAll.bins, highPriorNoNoiseBinsNegError, highPriorNoNoiseBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorNoNoiseAll.curve, 'color', [1 0.65 0], 'LineWidth', 2)
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
