%generates the low and high noise ("medium" and "high" noise in manuscript)
%psychometric curve and intercept plots in the visual noise experiment. 
%Figures 7d, 7e, and 7f for Monkey S.
%Figures 7g, 7h, and 7i for Monkey T. 
%Extended figures 7-1 and 7-2
%% load summarized data from appropriate folder for each monkey
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey S Visual Exp
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Monkey\Monkey T Visual Exp

%in vs. opp sac
%Monkey S: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey S Visual Exp\inVsOppSac
%Monkey T: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper
%data\Monkey\Monkey T Visual Exp\inVsOppSac

load('prior_lowAndHighNoise_bootstrap.mat')
% load('inSac_lowAndHighNoise_bootstrap.mat')
% load('oppSac_lowAndHighNoise_bootstrap.mat')

%% get error info 
lowPriorLowNoiseDiscreteNegError = lowPriorLowNoiseMean - lowPriorLowNoiseCI(1, :);
lowPriorLowNoiseDiscretePosError = lowPriorLowNoiseCI(2, :) - lowPriorLowNoiseMean;

highPriorLowNoiseDiscreteNegError = highPriorLowNoiseMean - highPriorLowNoiseCI(1, :);
highPriorLowNoiseDiscretePosError = highPriorLowNoiseCI(2, :) - highPriorLowNoiseMean;

lowPriorHighNoiseDiscreteNegError = lowPriorHighNoiseMean - lowPriorHighNoiseCI(1, :);
lowPriorHighNoiseDiscretePosError = lowPriorHighNoiseCI(2, :) - lowPriorHighNoiseMean;

highPriorHighNoiseDiscreteNegError = highPriorHighNoiseMean - highPriorHighNoiseCI(1, :);
highPriorHighNoiseDiscretePosError = highPriorHighNoiseCI(2, :) - highPriorHighNoiseMean;

%% plot psychometric curves
jmpspace = linspace(0, 6, 10000);

figure %Figures 7d and 7g. 
%low noise
errorbar(jumpSizes, lowPriorLowNoiseMean, lowPriorLowNoiseDiscreteNegError, lowPriorLowNoiseDiscretePosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorLowNoiseAll.curve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(jumpSizes, highPriorLowNoiseMean, highPriorLowNoiseDiscreteNegError, highPriorLowNoiseDiscretePosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorLowNoiseAll.curve, 'color', [1 0.65 0], 'LineWidth', 2)
box off
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% 
figure %Figures 7e and 7h. 
%high noise
errorbar(jumpSizes, lowPriorHighNoiseMean, lowPriorHighNoiseDiscreteNegError, lowPriorHighNoiseDiscretePosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, lowPriorHighNoiseAll.curve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(jumpSizes, highPriorHighNoiseMean, highPriorHighNoiseDiscreteNegError, highPriorHighNoiseDiscretePosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(jmpspace, highPriorHighNoiseAll.curve, 'color', [1 0.65 0], 'LineWidth', 2)
box off
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
%% 
%% plot intercept differences. Figures 7f and 7i. 
%low noise 
lowPriorLowNoiseZeroMean = mean(lowPriorLowNoiseZeroResp);
highPriorLowNoiseZeroMean = mean(highPriorLowNoiseZeroResp);

lowNoiseDiff = highPriorLowNoiseZeroMean - lowPriorLowNoiseZeroMean;

[lowPriorLowNoiseBootSam] = bootstrp(10000, @mean, lowPriorLowNoiseZeroResp);
[highPriorLowNoiseBootSam] = bootstrp(10000, @mean, highPriorLowNoiseZeroResp);

lowNoiseDiffBootSam = highPriorLowNoiseBootSam - lowPriorLowNoiseBootSam;
lowNoiseDiffCI = prctile(lowNoiseDiffBootSam, [2.5 97.5]);

%high noise
lowPriorHighNoiseZeroMean = mean(lowPriorHighNoiseZeroResp);
highPriorHighNoiseZeroMean = mean(highPriorHighNoiseZeroResp);

highNoiseDiff = highPriorHighNoiseZeroMean - lowPriorHighNoiseZeroMean;

[lowPriorHighNoiseBootSam] = bootstrp(10000, @mean, lowPriorHighNoiseZeroResp);
[highPriorHighNoiseBootSam] = bootstrp(10000, @mean, highPriorHighNoiseZeroResp);

highNoiseDiffBootSam = highPriorHighNoiseBootSam - lowPriorHighNoiseBootSam;
highNoiseDiffCI = prctile(highNoiseDiffBootSam, [2.5 97.5]);

%plot
errorbar(1:2, [lowNoiseDiff, highNoiseDiff], [lowNoiseDiff - lowNoiseDiffCI(1), highNoiseDiff - highNoiseDiffCI(1)], [lowNoiseDiffCI(2) - lowNoiseDiff, highNoiseDiffCI(2) - highNoiseDiff], 'ko', 'MarkerSize', 8, 'LineWidth', 1)
xlim([0.8 2.2])
xticks([1 2])
ylim([-0.1 0.4])
xticklabels({'Medium', 'High'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')


