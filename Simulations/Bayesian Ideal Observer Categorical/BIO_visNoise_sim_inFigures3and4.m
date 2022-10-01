%% Bayesian ideal observer model simulations for the visual noise experiments
%figures 3d, 3e, 4a, 4b, 4c
%calls function bayes_decision_simulation

%NOTE: noise levels referred to here as "no noise", "low noise', and "high
%noise" are "low", "medium", and "high" noise in the manuscript
%respectively.
%% simulation parameters
jumpDist = 2;
noJumpDist = 0.017;
maxX = 2;
x = linspace(0, maxX, 1000);

lowPrior = 0.22;
highPrior = 0.78;
medPrior = 0.5;

noNoise = 0.1;
lowNoise = 0.25;
highNoise = 0.5;

%% figure 3d 
%no noise figure
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, lowPrior), 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, medPrior), 'color', 'k', 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, highPrior), 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 2])
ylim([0 1])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% figure 3e. no noise intercepts

lowPriorNoNoiseIntercept = bayes_decision_simulation(0, jumpDist, noJumpDist, noNoise, lowPrior);
medPriorNoNoiseIntercept = bayes_decision_simulation(0, jumpDist, noJumpDist, noNoise, medPrior);
highPriorNoNoiseIntercept = bayes_decision_simulation(0, jumpDist, noJumpDist, noNoise, highPrior);

plot(1:3, [lowPriorNoNoiseIntercept, medPriorNoNoiseIntercept, highPriorNoNoiseIntercept], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 3.2])
xticks([1 2 3])
xticklabels({'0.28', '0.5', '0.78'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% figure 4a low noise curves
figure 
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, lowNoise, lowPrior), 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, lowNoise, highPrior), 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 2])
ylim([0 1])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% figure 4b. high noise curves
figure %high noise figure
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, highNoise, lowPrior), 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, highNoise, highPrior), 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 2])
ylim([0 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% Figure 4c. low and high noise intercept difference

lowPriorLowNoiseIntercept = bayes_decision_simulation(0, jumpDist, noJumpDist, lowNoise, lowPrior);
highPriorLowNoiseIntercept = bayes_decision_simulation(0, jumpDist, noJumpDist, lowNoise, highPrior);

lowPriorHighNoiseIntercept = bayes_decision_simulation(0, jumpDist, noJumpDist, highNoise, lowPrior);
highPriorHighNoiseIntercept = bayes_decision_simulation(0, jumpDist, noJumpDist, highNoise, highPrior);

figure
plot([1, 2], [highPriorLowNoiseIntercept - lowPriorLowNoiseIntercept, highPriorHighNoiseIntercept - lowPriorHighNoiseIntercept], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 2.2])
xticks([1 2])
xticklabels({'Low Noise', 'High Noise'})
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
box off
ylim([0 0.7])
yticks([0 0.2 0.4 0.6])



