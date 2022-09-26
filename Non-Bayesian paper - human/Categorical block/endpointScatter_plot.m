%% X scatter
for ii = 1:17
plot(1:3, [noNoiseSD.X(ii), lowNoiseSD.X(ii), highNoiseSD.X(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1); 
hold on
end
errorbar(1:3, [mean(noNoiseSD.X), mean(lowNoiseSD.X), mean(highNoiseSD.X)], [std(noNoiseSD.X)/sqrt(17), std(lowNoiseSD.X)/sqrt(17), std(highNoiseSD.X)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xticks([1 2 3])
xlim([0.8 3.2])
xticklabels({'Low', 'Medium', 'High'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% Y scatter
for ii = 1:17
plot(1:3, [noNoiseSD.Y(ii), lowNoiseSD.Y(ii), highNoiseSD.Y(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1); 
hold on
end
errorbar(1:3, [mean(noNoiseSD.Y), mean(lowNoiseSD.Y), mean(highNoiseSD.Y)], [std(noNoiseSD.Y)/sqrt(17), std(lowNoiseSD.Y)/sqrt(17), std(highNoiseSD.Y)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xticks([1 2 3])
xlim([0.8 3.2])
xticklabels({'Low', 'Medium', 'High'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
