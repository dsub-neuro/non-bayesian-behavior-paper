xspace = linspace(-2, 2, 10000);
%noise levels used in experiment
noNoiseSD = 0.1;
lowNoiseSD = 0.5;
highNoiseSD = 1;
priorMean = 0;
priorSD = 1;
%% bayesian inference schematic. Figure 5b. 
xspaceSch = linspace(-10, 10, 10000);
priorMeanSch = 0;
priorSDSch = 3;
likelihoodMean = 5;
likelihoodSD = 2;
[inferenceMean, inferenceSD] = gaussProduct(likelihoodMean, likelihoodSD, priorMeanSch, priorSDSch);
priorDistSch = normpdf(xspaceSch, priorMeanSch, priorSDSch);
likelihoodDistSch = normpdf(xspaceSch, likelihoodMean, likelihoodSD);
inferenceDist = normpdf(xspaceSch, inferenceMean, inferenceSD);

figure
plot(xspaceSch, priorDistSch, 'color', 'r', 'LineWidth', 2)
hold on
plot(xspaceSch, likelihoodDistSch, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(xspaceSch, inferenceDist, 'color', 'k', 'LineWidth', 2)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)


%% experimental distributions figure. Figure 5c
figure
noNoiseDist = normpdf(xspace, 1, noNoiseSD);
lowNoiseDist = normpdf(xspace, 1, lowNoiseSD);
highNoiseDist = normpdf(xspace, 1, highNoiseSD);
priorDist = normpdf(xspace, priorMean, priorSD);

plot(xspace, priorDist, 'color', 'r', 'LineWidth', 2)
hold on
plot(xspace, noNoiseDist, 'color', 'k', 'LineWidth', 2)
hold on
plot(xspace, lowNoiseDist, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(xspace, highNoiseDist, 'color', [0.5 0 0.5], 'LineWidth', 2)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
