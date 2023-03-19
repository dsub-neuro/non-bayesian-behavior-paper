%% get simulated psychometric curves
load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Categorical\summary_allTrials_4P_2.mat');
load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Categorical\summary_allTrials_4P_2.mat');

x1 = 1:17;
% x1 = fVal < 300; 4 best-fit participants
params = paramsFinal;
baselineCurveAll = NaN(17, 10000);
lowPriorNoNoiseCurveAll = NaN(17, 10000);
highPriorNoNoiseCurveAll = NaN(17, 10000);

lowPriorLowNoiseCurveAll = NaN(17, 10000);
highPriorLowNoiseCurveAll = NaN(17, 10000);

lowPriorHighNoiseCurveAll = NaN(17, 10000);
highPriorHighNoiseCurveAll = NaN(17, 10000);

maxX = 3;
x = linspace(0, maxX, 10000);

for ii = 1:17
   baselineCurveAll(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.noNoise(ii), params.medPriorOdds(ii), params.noNoiseLowerBound(ii), params.noNoiseLapse(ii));
   lowPriorNoNoiseCurveAll(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.noNoise(ii), params.lowPriorOdds(ii), params.noNoiseLowerBound(ii), params.noNoiseLapse(ii));
   highPriorNoNoiseCurveAll(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.noNoise(ii), params.highPriorOdds(ii), params.noNoiseLowerBound(ii), params.noNoiseLapse(ii));
   
   lowPriorLowNoiseCurveAll(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.lowNoise(ii), params.lowPriorOdds(ii), params.lowNoiseLowerBound(ii), params.lowNoiseLapse(ii));
   highPriorLowNoiseCurveAll(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.lowNoise(ii), params.highPriorOdds(ii), params.lowNoiseLowerBound(ii), params.lowNoiseLapse(ii));
   
   lowPriorHighNoiseCurveAll(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.highNoise(ii), params.lowPriorOdds(ii), params.highNoiseLowerBound(ii), params.highNoiseLapse(ii));
   highPriorHighNoiseCurveAll(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.highNoise(ii), params.highPriorOdds(ii), params.highNoiseLowerBound(ii), params.highNoiseLapse(ii));
end

baselineCurve = nanmean(baselineCurveAll(x1, :));
lowPriorNoNoiseCurve(ii, :) = nanmean(lowPriorNoNoiseCurveAll(x1, :));
highPriorNoNoiseCurve(ii, :) = nanmean(highPriorNoNoiseCurveAll(x1, :));

lowPriorLowNoiseCurve(ii, :) = nanmean(lowPriorLowNoiseCurveAll(x1, :));
highPriorLowNoiseCurve(ii, :) = nanmean(highPriorLowNoiseCurveAll(x1, :));
  
lowPriorHighNoiseCurve(ii, :) = nanmean(lowPriorHighNoiseCurveAll(x1, :));
highPriorHighNoiseCurve(ii, :) = nanmean(highPriorHighNoiseCurveAll(x1, :));
 

%% no noise
%%
bins = 0.125:0.25:4;
n = 17;
%n = size(baselinePsychBins, 1);
%% Figure 3f
figure %no noise
jmpspace = linspace(0, 4, 10000);
%baseline
errorbar(bins, nanmean(baselinePsychBins(x1, :)), nanstd(baselinePsychBins(x1, :))/sqrt(n), 'ko', 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(baselineCurveAll(x1, :)), nanstd(baselineCurveAll(x1, :))/sqrt(n), 'lineProps', {'LineWidth', 2, 'color', 'k'})
%plot(x, baselineCurve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, nanmean(lowPriorNoNoisePsychBins(x1, :)), nanstd(lowPriorNoNoisePsychBins(x1, :))/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(lowPriorNoNoiseCurveAll(x1, :)), nanstd(lowPriorNoNoiseCurveAll(x1, :))/sqrt(n), 'lineProps', {'LineWidth', 2, 'color', '[0 0.5 0.5]'})
%plot(x, lowPriorNoNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, nanmean(highPriorNoNoisePsychBins(x1, :)), nanstd(highPriorNoNoisePsychBins(x1, :))/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(highPriorNoNoiseCurveAll(x1, :)), nanstd(highPriorNoNoiseCurveAll(x1, :))/sqrt(n), 'lineProps', {'LineWidth', 2, 'color', '[1 0.65 0]'})

%plot(x, highPriorNoNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
ylim([0 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
%% Figure 4d
% low noise
figure
errorbar(bins, nanmean(lowPriorLowNoisePsychBins(x1, :)), nanstd(lowPriorLowNoisePsychBins(x1, :))/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(lowPriorLowNoiseCurveAll(x1, :)), nanstd(lowPriorLowNoiseCurveAll(x1, :))/sqrt(n), 'lineProps', {'LineWidth', 2, 'color', '[0 0.5 0.5]'})
%plot(x, lowPriorLowNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, nanmean(highPriorLowNoisePsychBins(x1, :)), nanstd(highPriorLowNoisePsychBins(x1, :))/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(highPriorLowNoiseCurveAll(x1, :)), nanstd(highPriorLowNoiseCurveAll(x1, :))/sqrt(n), 'lineProps', {'LineWidth', 2, 'color', '[1 0.65 0]'})
%plot(x, highPriorLowNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
ylim([0 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% Figure 4e
% high noise
figure
errorbar(bins, nanmean(lowPriorHighNoisePsychBins(x1, :)), nanstd(lowPriorHighNoisePsychBins(x1, :))/sqrt(n), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(lowPriorHighNoiseCurveAll(x1, :)), nanstd(lowPriorHighNoiseCurveAll(x1, :))/sqrt(n), 'lineProps', {'LineWidth', 2, 'color', '[0 0.5 0.5]'})
%plot(x, lowPriorHighNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, nanmean(highPriorHighNoisePsychBins(x1, :)), nanstd(highPriorHighNoisePsychBins(x1, :))/sqrt(n), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(highPriorHighNoiseCurveAll(x1, :)), nanstd(highPriorHighNoiseCurveAll(x1, :))/sqrt(n), 'lineProps', {'LineWidth', 2, 'color', '[1 0.65 0]'})
%plot(x, highPriorHighNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
yticks([0 0.25 0.5 0.75 1])
xlim([0 2.5])
ylim([0 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% parameter plots
%noise levels
figure
for ii = 1:17
     %if x1(ii) == 1
        plot(1:3, [params.noNoise(ii), params.lowNoise(ii), params.highNoise(ii)], '.-', 'color', [0.7 0.7 0.7], 'MarkerSize', 2)
        hold on
    %end
end
errorbar(1:3, [mean(params.noNoise(x1)), mean(params.lowNoise(x1)), mean(params.highNoise(x1))], [std(params.noNoise(x1))/sqrt(n), std(params.lowNoise(x1))/sqrt(n), std(params.highNoise(x1))/sqrt(n)], 'ko', 'MarkerSize', 10, 'LineWidth', 1.5)
xticks([1 2 3])
xlim([0.8 3.2])
ylim([0 0.8])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%priors
figure
negOdds = [params.lowPriorOdds(x1), params.medPriorOdds(x1), params.highPriorOdds(x1)];
priors = priorFromNegLogOdds(negOdds);
for ii = 1:n
        plot(1:3, priors(ii, :), '.-', 'color', [0.7 0.7 0.7], 'MarkerSize', 2)
        hold on
end
errorbar(1:3, mean(priors), std(priors)/sqrt(n), 'ko', 'MarkerSize', 10, 'LineWidth', 1.5)
xticks([1 2 3])
xlim([0.8 3.2])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%jump dists
figure
for ii = 1:17
    %if x1(ii) == 1
        plot(1:2, [params.jumpDist(ii), params.noJumpDist(ii)], '.-', 'color', [0.7 0.7 0.7], 'MarkerSize', 2)
        hold on
    %end
end
errorbar(1:2, [mean(params.jumpDist(x1)), mean(params.noJumpDist(x1))], [std(params.jumpDist(x1))/sqrt(n), std(params.noJumpDist(x1))/sqrt(n)], 'ko', 'MarkerSize', 10, 'LineWidth', 1.5)
xticks([1 2])
xlim([0.8 2.2])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%histogram of objective value functions
histogram(fValFinal, 50)
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
