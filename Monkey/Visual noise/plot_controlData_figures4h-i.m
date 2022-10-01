%% generates the control experiment plots in Figures 4h (Monkey S) and 4i (Monkey T)
%load appropriate file for each monkey
%Monkey S: load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Visual Exp\priorDiff_beh_control.mat')
%Monkey T: load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Visual Exp\priorDiff_beh_control.mat')

% %Monkey S
% n = 40; 
% %Monkey T
% n = 18; 

figure
 for ii = 1:n
     plot(1:3, [priorDiff.noNoise(ii), priorDiff.lowNoise(ii), priorDiff.highNoise(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
     hold on
 end
 
 means = [nanmean(priorDiff.noNoise), nanmean(priorDiff.lowNoise), nanmean(priorDiff.highNoise)];
 err = [nanstd(priorDiff.noNoise)/sqrt(n), nanstd(priorDiff.lowNoise)/sqrt(n), nanstd(priorDiff.highNoise)/sqrt(n)];
 errorbar(1:3, means, err, 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 3.2])
ylim([0 1])
xticks([1 2 3])
xticklabels({'low', 'medium', 'high'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')