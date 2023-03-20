
%% get binned error info 
lowPriorLowNoiseDiscreteNegError = lowPriorLowNoiseMean - lowPriorLowNoiseCI(1, :);
lowPriorLowNoiseDiscretePosError = lowPriorLowNoiseCI(2, :) - lowPriorLowNoiseMean;

highPriorLowNoiseDiscreteNegError = highPriorLowNoiseMean - highPriorLowNoiseCI(1, :);
highPriorLowNoiseDiscretePosError = highPriorLowNoiseCI(2, :) - highPriorLowNoiseMean;

lowPriorHighNoiseDiscreteNegError = lowPriorHighNoiseMean - lowPriorHighNoiseCI(1, :);
lowPriorHighNoiseDiscretePosError = lowPriorHighNoiseCI(2, :) - lowPriorHighNoiseMean;

highPriorHighNoiseDiscreteNegError = highPriorHighNoiseMean - highPriorHighNoiseCI(1, :);
highPriorHighNoiseDiscretePosError = highPriorHighNoiseCI(2, :) - highPriorHighNoiseMean;

%% get simulated psychometric curves

baselineCurve = NaN(1, 10000);
lowPriorNoNoiseCurve = NaN(1, 10000);
highPriorNoNoiseCurve = NaN(1, 10000);

lowPriorLowNoiseCurve = NaN(1, 10000);
highPriorLowNoiseCurve = NaN(1, 10000);

lowPriorHighNoiseCurve = NaN(1, 10000);
highPriorHighNoiseCurve = NaN(1, 10000);

maxX = 6;
x = linspace(0, maxX, 10000);

for ii = 1
   baselineCurve(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.noNoise(ii), params.medPriorOdds(ii), params.noNoiseLowerBound(ii), params.noNoiseLapse(ii));
   lowPriorNoNoiseCurve(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.noNoise(ii), params.lowPriorOdds(ii), params.noNoiseLowerBound(ii), params.noNoiseLapse(ii));
   highPriorNoNoiseCurve(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.noNoise(ii), params.highPriorOdds(ii), params.noNoiseLowerBound(ii), params.noNoiseLapse(ii));
   
   lowPriorLowNoiseCurve(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.lowNoise(ii), params.lowPriorOdds(ii), params.lowNoiseLowerBound(ii), params.lowNoiseLapse(ii));
   highPriorLowNoiseCurve(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.lowNoise(ii), params.highPriorOdds(ii), params.lowNoiseLowerBound(ii), params.lowNoiseLapse(ii));
   
   lowPriorHighNoiseCurve(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.highNoise(ii), params.lowPriorOdds(ii), params.highNoiseLowerBound(ii), params.highNoiseLapse(ii));
   highPriorHighNoiseCurve(ii, :) = bayes_decision_simulation_lapses(x, params.jumpDist(ii), params.noJumpDist(ii), params.highNoise(ii), params.highPriorOdds(ii), params.highNoiseLowerBound(ii), params.highNoiseLapse(ii));
end

%% low noise figure

figure %Figures 7d and 7g. 
%low noise
errorbar(jumpSizes, lowPriorLowNoiseMean, lowPriorLowNoiseDiscreteNegError, lowPriorLowNoiseDiscretePosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(x, lowPriorLowNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(jumpSizes, highPriorLowNoiseMean, highPriorLowNoiseDiscreteNegError, highPriorLowNoiseDiscretePosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(x, highPriorLowNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
box off
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% high noise figure

figure %Figures 7e and 7h. 
%high noise
errorbar(jumpSizes, lowPriorHighNoiseMean, lowPriorHighNoiseDiscreteNegError, lowPriorHighNoiseDiscretePosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(x, lowPriorHighNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(jumpSizes, highPriorHighNoiseMean, highPriorHighNoiseDiscreteNegError, highPriorHighNoiseDiscretePosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(x, highPriorHighNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
box off
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% no noise 
%get errors for bins
%baseline
baselineBinsCI = prctile(baseline.bins, [2.5 97.5]);

%low prior
lowPriorNoNoiseBinsCI = prctile(lowPriorNoNoise.bins, [2.5 97.5]);

%high prior
highPriorNoNoiseBinsCI = prctile(highPriorNoNoise.bins, [2.5 97.5]);

lowPriorNoNoiseBinsNegError = lowPriorNoNoiseAll.bins - lowPriorNoNoiseBinsCI(1, :);
lowPriorNoNoiseBinsPosError = lowPriorNoNoiseBinsCI(2, :) - lowPriorNoNoiseAll.bins;

baselineBinsNegError = baselineAll.bins - baselineBinsCI(1, :);
baselineBinsPosError = baselineBinsCI(2, :) - baselineAll.bins;

highPriorNoNoiseBinsNegError = highPriorNoNoiseAll.bins - highPriorNoNoiseBinsCI(1, :);
highPriorNoNoiseBinsPosError = highPriorNoNoiseBinsCI(2, :) - highPriorNoNoiseAll.bins;

%% figure
figure
bins = 0.25:0.5:5.75;
errorbar(bins, lowPriorNoNoiseAll.bins, lowPriorNoNoiseBinsNegError, lowPriorNoNoiseBinsPosError, 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(x, lowPriorNoNoiseCurve, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
errorbar(bins, baselineAll.bins, baselineBinsNegError, baselineBinsPosError, 'o', 'color', [0 0 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(x, baselineCurve, 'color', 'k', 'LineWidth', 2)
hold on
errorbar(bins, highPriorNoNoiseAll.bins, highPriorNoNoiseBinsNegError, highPriorNoNoiseBinsPosError, 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
hold on
plot(x, highPriorNoNoiseCurve, 'color', [1 0.65 0], 'LineWidth', 2)
ylim([0 1])
xlim([0 6])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')


%% get parameter plots

%noise levels
plot(1:3, [params.noNoise, params.lowNoise, params.highNoise], 'ko', 'MarkerSize', 10, 'LineWidth', 1.5)
xticks([1 2 3])
xlim([0.8 3.2])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%priors
negOdds = [params.lowPriorOdds, params.medPriorOdds, params.highPriorOdds];
priors = priorFromNegLogOdds(negOdds);
plot(1:3, priors, 'ko', 'MarkerSize', 10, 'LineWidth', 1.5)
xticks([1 2 3])
xlim([0.8 3.2])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylim([0.4 0.6])
%jump and non-jump dist
plot(1:2, [params.jumpDist, params.noJumpDist], 'ko', 'MarkerSize', 10, 'LineWidth', 1.5)
xticks([1 2])
xlim([0.8 2.2])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
%ylim([-0.1 3.5])
