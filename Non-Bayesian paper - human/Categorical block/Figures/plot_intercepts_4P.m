load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_allTrials_4P.mat')

%% no noise intercepts

for ii = 1:17
    plot(1:3, [min.lowPriorNoNoise(ii), min.baseline(ii), min.highPriorNoNoise(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end 
errorbar(1:3, [mean(min.lowPriorNoNoise), mean(min.baseline), mean(min.highPriorNoNoise)], [std(min.lowPriorNoNoise)/sqrt(17), std(min.baseline)/sqrt(17), std(min.highPriorNoNoise)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 3.2])
xticks([1 2 3])
yticks([0 0.3 0.6])
xticklabels({'0.22', '0.5', '0.78'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
 
 
 %% plot low and high noise intercept difference
 
 lowNoiseDiff = min.highPriorLowNoise - min.lowPriorLowNoise;
 highNoiseDiff = min.highPriorHighNoise - min.lowPriorHighNoise;
 
 for ii = 1:17
    plot(1:2, [lowNoiseDiff(ii), highNoiseDiff(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
 end
errorbar(1:2, [mean(lowNoiseDiff), mean(highNoiseDiff)], [std(lowNoiseDiff)/sqrt(17), std(highNoiseDiff)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 2.2])
xticks([1 2])
yticks([-0.2 0 0.2 0.4])
xticklabels({'Medium noise', 'High noise'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')