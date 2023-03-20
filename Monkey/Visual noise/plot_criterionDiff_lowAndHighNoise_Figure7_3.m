load('curves_SDT.mat')
load('bootstrap_curves_SDT.mat')
load('bootstrapped_criterion_diff.mat')

data = allData.Criterion;

lowNoiseDiff = data.lowPriorLowNoise - data.highPriorLowNoise;
highNoiseDiff = data.lowPriorHighNoise - data.highPriorHighNoise;

figure
errorbar([1, 1.2], [lowNoiseDiff, highNoiseDiff], [(lowNoiseDiff - ciLowNoise(1)), (highNoiseDiff - ciHighNoise(1))], [(ciLowNoise(2) - lowNoiseDiff), (ciHighNoise(2) - highNoiseDiff)],  'ko', 'LineWidth', 2, 'MarkerSize', 10)
xlim([0.9 1.3])
xticks([1 1.2])
%ylim([-0.5 1.25])
xticklabels({'Low Noise', 'High Noise'})
ylabel('Criterion difference (0.2 - 0.8)')
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
box off