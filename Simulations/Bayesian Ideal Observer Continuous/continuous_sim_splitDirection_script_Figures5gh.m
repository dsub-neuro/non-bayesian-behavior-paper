%% opposite to saccade: right jumps
priorMean = -0.5;
priorSD = 1;

%noise levels used in experiment
noNoiseSD = 0.1;
lowNoiseSD = 0.5;
highNoiseSD = 1;
infNoiseSD = Inf;

xspace = linspace(0, 2, 10000);

[noNoiseResp, noNoiseSD] = gaussProduct(xspace, noNoiseSD, priorMean, priorSD);
[lowNoiseResp, lowNoiseSD] = gaussProduct(xspace, lowNoiseSD, priorMean, priorSD);
[highNoiseResp, highNoiseSD] = gaussProduct(xspace, highNoiseSD, priorMean, priorSD);
[infNoiseResp, infNoiseSD] = gaussProduct(xspace, infNoiseSD, priorMean, priorSD);

figure
plot(xspace, xspace - noNoiseResp, 'color', 'k', 'LineWidth', 2)
hold on
plot(xspace, xspace - lowNoiseResp, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(xspace, xspace - highNoiseResp, 'color', [0.5 0 0.5], 'LineWidth', 2)
hold on
% plot(xspace, xspace - infNoiseResp, 'color', 'r', 'LineWidth', 2)
% box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
hold on

%% 
%% opposite to saccade: left jumps
priorMean = 0.5;
priorSD = 1;

%noise levels used in experiment
noNoiseSD = 0.1;
lowNoiseSD = 0.5;
highNoiseSD = 1;
infNoiseSD = Inf;

xspace = linspace(-2, 0, 10000);

[noNoiseResp, noNoiseSD] = gaussProduct(xspace, noNoiseSD, priorMean, priorSD);
[lowNoiseResp, lowNoiseSD] = gaussProduct(xspace, lowNoiseSD, priorMean, priorSD);
[highNoiseResp, highNoiseSD] = gaussProduct(xspace, highNoiseSD, priorMean, priorSD);
[infNoiseResp, infNoiseSD] = gaussProduct(xspace, infNoiseSD, priorMean, priorSD);

%figure
plot(xspace, xspace - noNoiseResp, 'color', 'k', 'LineWidth', 2)
hold on
plot(xspace, xspace - lowNoiseResp, 'color', [0 0.5 0.5], 'LineWidth', 2)
hold on
plot(xspace, xspace - highNoiseResp, 'color', [0.5 0 0.5], 'LineWidth', 2)
hold on
% plot(xspace, xspace - infNoiseResp, 'color', 'r', 'LineWidth', 2)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
hold on
ylim([-2 2])