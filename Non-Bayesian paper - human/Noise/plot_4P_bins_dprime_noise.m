data = contrast;
bins = 0.125:binSize:3.875;
jmpspace = linspace(0, 4, 10000);
nSubjects = 9; 

lowNoiseBinsMean = nanmean(data.lowNoiseBins);
lowNoiseBinsError = nanstd(data.lowNoiseBins)/sqrt(9);

highNoiseBinsMean = nanmean(data.highNoiseBins);
highNoiseBinsError = nanstd(data.highNoiseBins)/sqrt(9);

figure
errorbar(bins, lowNoiseBinsMean, lowNoiseBinsError, 'ko', 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, data.lowNoiseCurve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, highNoiseBinsMean, highNoiseBinsError, 'ro', 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, data.highNoiseCurve, 'color', 'r', 'LineWidth', 2)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])

figure
for ii = 1:nSubjects
    plot(1:2, [data.DPrime.lowNoise(ii), data.DPrime.highNoise(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end
errorbar(1:2, [nanmean(data.DPrime.lowNoise) nanmean(data.DPrime.highNoise)], [nanstd(data.DPrime.lowNoise)/sqrt(nSubjects) nanstd(data.DPrime.highNoise)/sqrt(nSubjects)], 'ko', 'LineWidth', 2, 'MarkerSize', 10)
xlim([0.8 2.2])
xticks([1 2])
%ylim([1.3 2.5])
xticklabels({'Low Noise', 'High Noise'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
