%same code used to plot perceptron and combined model simulation figures. 
%remember to load the appropriate data from 'C:\Users\Divya\Documents\Divya
%data\Non Bayesian behavior paper data\Simulations\Bootstrap perceptron and combined\Experimental conditions'
%% get CI info for bins
baselineBinsCI = prctile(bins.baseline, [2.5 97.5]);
lowPriorNoNoiseBinsCI = prctile(bins.lowPriorNoNoise, [2.5 97.5]);
highPriorNoNoiseBinsCI = prctile(bins.highPriorNoNoise, [2.5 97.5]);

lowPriorLowNoiseBinsCI = prctile(bins.lowPriorLowNoise, [2.5 97.5]);
highPriorLowNoiseBinsCI = prctile(bins.highPriorLowNoise, [2.5 97.5]);

lowPriorHighNoiseBinsCI = prctile(bins.lowPriorHighNoise, [2.5 97.5]);
highPriorHighNoiseBinsCI = prctile(bins.highPriorHighNoise, [2.5 97.5]);

%% plot no noise condition. Figure 9e (perceptron only, early). Figure 10b (combined, early), Figure 10f (combined, late), Figure 10g (perceptron, late)
%get errors
%baseline
baselineBinsMean = nanmean(bins.baseline);
baselineBinsNegError = baselineBinsMean - baselineBinsCI(1, :);
baselineBinsPosError = baselineBinsCI(2, :) - baselineBinsMean;

baselineCurvesMean = nanmean(curves.baseline);

%low prior
lowPriorNoNoiseBinsMean = nanmean(bins.lowPriorNoNoise);
lowPriorNoNoiseBinsNegError = lowPriorNoNoiseBinsMean - lowPriorNoNoiseBinsCI(1, :);
lowPriorNoNoiseBinsPosError = lowPriorNoNoiseBinsCI(2, :) - lowPriorNoNoiseBinsMean;

lowPriorNoNoiseCurvesMean = nanmean(curves.lowPriorNoNoise);

%high prior
highPriorNoNoiseBinsMean = nanmean(bins.highPriorNoNoise);
highPriorNoNoiseBinsNegError = highPriorNoNoiseBinsMean - highPriorNoNoiseBinsCI(1, :);
highPriorNoNoiseBinsPosError = highPriorNoNoiseBinsCI(2, :) - highPriorNoNoiseBinsMean;

highPriorNoNoiseCurvesMean = nanmean(curves.highPriorNoNoise);

% plot
binEdges = 0.25:0.5:4.75;
jmpspace = linspace(0, 5, 1000);
%plot curves
figure %with saccade
errorbar(binEdges, lowPriorNoNoiseBinsMean, lowPriorNoNoiseBinsNegError, lowPriorNoNoiseBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorNoNoiseCurvesMean, 'color', [0 0.5 0.5], 'LineWidth', 1)
hold on
errorbar(binEdges, baselineBinsMean, baselineBinsNegError, baselineBinsPosError, 'o', 'color', [0 0 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, baselineCurvesMean, 'color', [0 0 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
errorbar(binEdges, highPriorNoNoiseBinsMean, highPriorNoNoiseBinsNegError, highPriorNoNoiseBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorNoNoiseCurvesMean, 'color', [1 0.65 0], 'LineWidth', 1)
ylim([0.25 0.75])
xlim([0 3])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')


%% plot low noise condition. Figure 10c (combined, early)
%get errors
%low prior
lowPriorLowNoiseBinsMean = nanmean(bins.lowPriorLowNoise);
lowPriorLowNoiseBinsNegError = lowPriorLowNoiseBinsMean - lowPriorLowNoiseBinsCI(1, :);
lowPriorLowNoiseBinsPosError = lowPriorLowNoiseBinsCI(2, :) - lowPriorLowNoiseBinsMean;

lowPriorLowNoiseCurvesMean = nanmean(curves.lowPriorLowNoise);

%high prior
highPriorLowNoiseBinsMean = nanmean(bins.highPriorLowNoise);
highPriorLowNoiseBinsNegError = highPriorLowNoiseBinsMean - highPriorLowNoiseBinsCI(1, :);
highPriorLowNoiseBinsPosError = highPriorLowNoiseBinsCI(2, :) - highPriorLowNoiseBinsMean;

highPriorLowNoiseCurvesMean = nanmean(curves.highPriorLowNoise);

%plot curves
figure %with saccade
errorbar(binEdges, lowPriorLowNoiseBinsMean, lowPriorLowNoiseBinsNegError, lowPriorLowNoiseBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorLowNoiseCurvesMean, 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
errorbar(binEdges, highPriorLowNoiseBinsMean, highPriorLowNoiseBinsNegError, highPriorLowNoiseBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorLowNoiseCurvesMean,'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
ylim([0.25 0.75])
xlim([0 3])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% plot high noise condition. Figure 10d (combined, early)
%get errors
%low prior
lowPriorHighNoiseBinsMean = nanmean(bins.lowPriorHighNoise);
lowPriorHighNoiseBinsNegError = lowPriorHighNoiseBinsMean - lowPriorHighNoiseBinsCI(1, :);
lowPriorHighNoiseBinsPosError = lowPriorHighNoiseBinsCI(2, :) - lowPriorHighNoiseBinsMean;

lowPriorHighNoiseCurvesMean = nanmean(curves.lowPriorHighNoise);

%high prior
highPriorHighNoiseBinsMean = nanmean(bins.highPriorHighNoise);
highPriorHighNoiseBinsNegError = highPriorHighNoiseBinsMean - highPriorHighNoiseBinsCI(1, :);
highPriorHighNoiseBinsPosError = highPriorHighNoiseBinsCI(2, :) - highPriorHighNoiseBinsMean;

highPriorHighNoiseCurvesMean = nanmean(curves.highPriorHighNoise);

%plot curves
figure %with saccade
errorbar(binEdges, lowPriorHighNoiseBinsMean, lowPriorHighNoiseBinsNegError, lowPriorHighNoiseBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorHighNoiseCurvesMean, 'color', [0 0.5 0.5], 'LineWidth', 1)
hold on
errorbar(binEdges, highPriorHighNoiseBinsMean, highPriorHighNoiseBinsNegError, highPriorHighNoiseBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorHighNoiseCurvesMean, 'color', [1 0.65 0], 'LineWidth', 1)
ylim([0.25 0.75])
xlim([0 3])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% plot mean diff across noise levels. Figure 10e. 
noNoiseDiff = min.highPriorNoNoise - min.lowPriorNoNoise;
noNoiseDiffCI = prctile(noNoiseDiff, [2.5 97.5]);

lowNoiseDiff = min.highPriorLowNoise - min.lowPriorLowNoise;
lowNoiseDiffCI = prctile(lowNoiseDiff, [2.5 97.5]);

highNoiseDiff = min.highPriorHighNoise - min.lowPriorHighNoise;
highNoiseDiffCI = prctile(highNoiseDiff, [2.5 97.5]);

diffMeans = [nanmean(noNoiseDiff), nanmean(lowNoiseDiff), nanmean(highNoiseDiff)];
diffNegError = [nanmean(noNoiseDiff) - noNoiseDiffCI(1), nanmean(lowNoiseDiff) - lowNoiseDiffCI(1), nanmean(highNoiseDiff) - highNoiseDiffCI(1)];
diffPosError = [noNoiseDiffCI(2) - nanmean(noNoiseDiff), lowNoiseDiffCI(2) - nanmean(lowNoiseDiff), highNoiseDiffCI(2) - nanmean(highNoiseDiff)]; 

%%
figure
for ii = 1:500
plot(1:3, [noNoiseDiff(ii), lowNoiseDiff(ii), highNoiseDiff(ii)], '.-', 'color', [0.7 0.7 0.7])
hold on
end
hold on
figure
errorbar(1:3, diffMeans, diffNegError, diffPosError, 'ko', 'MarkerSize', 8, 'LineWidth', 1)
xlim([0.8 3.2])
xticks([2 3])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

