%% Generates endpoint scatter plots for continuous experiment in Figure 6c and 6d

load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\endpoints_noise.mat')

%% X scatter. %Figure 6c. 
for ii = 1:11
plot(1:4, [endpoints_x(ii, 1), endpoints_x(ii, 2), endpoints_x(ii, 3), endpoints_x(ii, 4)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1); 
hold on
end
xMean = nanmean(endpoints_x);
xErr = nanstd(endpoints_x)./sqrt(11);
errorbar(1:4, xMean, xErr, 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xticks([1 2 3 4])
xlim([0.8 4.2])
xticklabels({'Low', 'Medium', 'High', 'Infinite'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% Y scatter. Figure 6d.
figure
for ii = 1:11
plot(1:4, [endpoints_y(ii, 1), endpoints_y(ii, 2), endpoints_y(ii, 3), endpoints_y(ii, 4)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1); 
hold on
end
yMean = nanmean(endpoints_y);
yErr = nanstd(endpoints_y)./sqrt(11);
errorbar(1:4, yMean, yErr, 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xticks([1 2 3 4])
xlim([0.8 4.2])
xticklabels({'Low', 'Medium', 'High', 'Infinite'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
