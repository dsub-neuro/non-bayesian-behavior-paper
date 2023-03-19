% generates the Criterion plots for the human categorical experiment for Figure 4-1. 
%Note that the noise levels referred to here as "no", "low", and "high"
%noise are "low", "medium", and "high" respectively in the manuscript

load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Categorical\summary_allTrials_4P_2.mat')
c = CriterionVals;

%% no noise intercepts. Figure 3g. 

for ii = 1:17
    plot(1:3, [c.lowPriorNoNoise(ii), c.baseline(ii), c.highPriorNoNoise(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end 
errorbar(1:3, [mean(c.lowPriorNoNoise), mean(c.baseline), mean(c.highPriorNoNoise)], [std(c.lowPriorNoNoise)/sqrt(17), std(c.baseline)/sqrt(17), std(c.highPriorNoNoise)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 3.2])
xticks([1 2 3])
yticks([0 0.3 0.6])
xticklabels({'0.22', '0.5', '0.78'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
 
 
 %% plot low and high noise intercept difference. Figure 4f.
 
 lowNoiseDiff = c.highPriorLowNoise - c.lowPriorLowNoise;
 highNoiseDiff = c.highPriorHighNoise - c.lowPriorHighNoise;
 
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