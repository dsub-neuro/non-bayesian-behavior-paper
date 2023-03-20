load('curves_SDT.mat')
load('bootstrap_curves_SDT.mat')
load('bootstrapped_criterion_diff.mat')

%% plot no noise criterions
c = allData.Criterion;
lowPriorCI = bootstrapCI.lowPriorNoNoiseC;
baselineCI = bootstrapCI.baselineC;
highPriorCI = bootstrapCI.highPriorNoNoiseC;

figure
errorbar(1:3, [c.lowPriorNoNoise, c.baseline, c.highPriorNoNoise], [(c.lowPriorNoNoise - lowPriorCI(2)), (c.baseline - baselineCI(2)), (c.highPriorNoNoise - highPriorCI(2))], [(lowPriorCI(1) - c.lowPriorNoNoise), (baselineCI(1) - c.baseline), (highPriorCI(1) - c.highPriorNoNoise)],  'ko', 'LineWidth', 2, 'MarkerSize', 10)
xlim([0.8 3.2])
xticks([1 2 3])
ylim([-0.9 0.9])
xticklabels({'0.2','0.5','0.8'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

