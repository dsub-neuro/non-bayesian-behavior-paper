%% Bayesian ideal observer model simulations for the motor noise experiment
%figure 8a, 8b, 8c
%calls function bayes_decision_simulation

%NOTE: noise levels referred to here as "no noise", "low noise', and "high
%noise" are "low", "medium", and "high" noise in the manuscript
%respectively.
%% simulation parameters
maxX = 6;
x = linspace(0, maxX, 1000);

lowPrior = 0.2;
highPrior = 0.8;
medPrior = 0.5;

noNoise = 0.5;

%% no saccade. Figure 8a
jumpDist = 5;
noJumpDist = 0.25;
figure
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, lowPrior), 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, medPrior), 'color', 'k', 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, highPrior), 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 maxX])
ylim([0 1])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')


%% with saccade. Figure 8b.
jumpDist = 5;
noJumpDist = 1;

figure
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, lowPrior), 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, medPrior), 'color', 'k', 'LineWidth', 2)
hold on
plot(x, bayes_decision_simulation(x, jumpDist, noJumpDist, noNoise, highPrior), 'color', [1 0.65 0], 'LineWidth', 2)
xlim([0 maxX])
ylim([0 1])
yticks([0 0.25 0.5 0.75 1])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% low and high motor noise intercept diff. Figure 8c.

lowPriorLowNoiseIntercept = bayes_decision_simulation(0, 5, 0.25, 0.5, 0.2);
highPriorLowNoiseIntercept = bayes_decision_simulation(0, 5, 0.25, 0.5, 0.8);

lowPriorHighNoiseIntercept = bayes_decision_simulation(0, 5, 1, 0.5, 0.2);
highPriorHighNoiseIntercept = bayes_decision_simulation(0, 5, 1, 0.5, 0.8);

figure
plot([1, 2], [highPriorLowNoiseIntercept - lowPriorLowNoiseIntercept, highPriorHighNoiseIntercept - lowPriorHighNoiseIntercept], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 2.2])
xticks([1 2])
xticklabels({'Low Noise', 'High Noise'})
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
box off
ylim([0.1 0.3])
yticks([0.1 0.2 0.3])



