load('criterion_diff.mat')

figure
errorbar([1, 1.2], [noSacDiffC, sacDiffC], [(noSacDiffC - ciCriterionDiffNoSac(1)), (sacDiffC - ciCriterionDiffSac(1))], [(ciCriterionDiffNoSac(2) - noSacDiffC), (ciCriterionDiffSac(2) - sacDiffC)],  'ko', 'LineWidth', 2, 'MarkerSize', 10)
xlim([0.9 1.3])
xticks([1 1.2])
%ylim([-0.5 1.25])
xticklabels({'No saccade', 'With saccade'})
ylabel('Criterion difference (0.2 - 0.8)')
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
box off