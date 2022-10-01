%% generates the no-noise prior learning intercept plot in Figure 7c

%Monkey S
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Visual Exp')

load('prior_noNoise_bootstrap.mat')

%% get errors
%baseline
baselineInterceptCI = prctile(baseline.min, [2.5 97.5]);

%low prior
lowPriorNoNoiseInterceptCI = prctile(lowPriorNoNoise.min, [2.5 97.5]);

%high prior
highPriorNoNoiseInterceptCI = prctile(highPriorNoNoise.min, [2.5 97.5]);

%% plot intercepts 
errorbar(1:3, [lowPriorNoNoiseAll.min, baselineAll.min, highPriorNoNoiseAll.min], [lowPriorNoNoiseAll.min - lowPriorNoNoiseInterceptCI(1), baselineAll.min - baselineInterceptCI(1), highPriorNoNoiseAll.min - highPriorNoNoiseInterceptCI(1)], [lowPriorNoNoiseInterceptCI(2) - lowPriorNoNoiseAll.min, baselineInterceptCI(2) - baselineAll.min, highPriorNoNoiseInterceptCI(2) - highPriorNoNoiseAll.min], 'ko', 'MarkerSize', 10, 'LineWidth', 1)
xlim([0.8 3.2])
xticks([1 2 3])
ylim([0 0.7])
yticks([0 0.35 0.7])
xticklabels({'0.2', '0.5', '0.8'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

hold on

%% Monkey T
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Visual Exp')
load('prior_noNoise_bootstrap.mat')


%% get errors
%baseline
baselineInterceptCI = prctile(baseline.min, [2.5 97.5]);

%low prior
lowPriorNoNoiseInterceptCI = prctile(lowPriorNoNoise.min, [2.5 97.5]);

%high prior
highPriorNoNoiseInterceptCI = prctile(highPriorNoNoise.min, [2.5 97.5]);


%% plot intercepts 
errorbar(1:3, [lowPriorNoNoiseAll.min, baselineAll.min, highPriorNoNoiseAll.min], [lowPriorNoNoiseAll.min - lowPriorNoNoiseInterceptCI(1), baselineAll.min - baselineInterceptCI(1), highPriorNoNoiseAll.min - highPriorNoNoiseInterceptCI(1)], [lowPriorNoNoiseInterceptCI(2) - lowPriorNoNoiseAll.min, baselineInterceptCI(2) - baselineAll.min, highPriorNoNoiseInterceptCI(2) - highPriorNoNoiseAll.min], 'k^', 'MarkerSize', 10, 'LineWidth', 1)
xlim([0.8 3.2])
xticks([1 2 3])
ylim([0 0.7])
yticks([0 0.35 0.7])
xticklabels({'0.2', '0.5', '0.8'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

