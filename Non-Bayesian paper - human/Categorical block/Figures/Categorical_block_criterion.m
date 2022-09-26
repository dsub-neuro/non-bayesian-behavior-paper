load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_allTrials.mat')
c = CriterionVals;

%% plot Criterions for No noise condition
for p = 1:17
    plot(1:3, [c.lowPriorNoNoise(p), c.baseline(p), c.highPriorNoNoise(p)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end
errorbar(1:3, [mean(c.lowPriorNoNoise), mean(c.baseline), mean(c.highPriorNoNoise)], [std(c.lowPriorNoNoise)/sqrt(17), std(c.baseline)/sqrt(17), std(c.highPriorNoNoise)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 3.2])
xticks([1 2 3])
xticklabels({'0.1', '0.5', '0.9'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
%% plot Criterion difference for low and high noise conditions
lowNoiseDiff = c.lowPriorLowNoise - c.highPriorLowNoise;
highNoiseDiff = c.lowPriorHighNoise - c.highPriorHighNoise;

for p = 1:17
    plot([1, 1.2], [lowNoiseDiff(p), highNoiseDiff(p)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end
errorbar([1, 1.2], [mean(lowNoiseDiff), mean(highNoiseDiff)], [std(lowNoiseDiff)/sqrt(17), std(highNoiseDiff)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.9 1.3])
xticks([1 1.2])
ylim([-0.5 1.25])
xticklabels({'Low Noise', 'High Noise'})
ylabel('Criterion difference (0.1 - 0.9)')
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
box off