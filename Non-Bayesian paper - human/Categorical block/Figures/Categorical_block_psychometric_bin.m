bins = 0.25:0.25:4;
xspace = linspace(0, 4, 10000);
n = size(baselinePsychBins, 1);
%% no noise plot
%low prior
errorbar(bins, nanmean(lowPriorNoNoisePsychBins), nanstd(lowPriorNoNoisePsychBins)/sqrt(n), 'bo')
hold on
plot(xspace, nanmean(lowPriorNoNoisePsychCurves), 'color', 'b')
hold on
%baseline
errorbar(bins, nanmean(baselinePsychBins), nanstd(baselinePsychBins)/sqrt(n), 'ko')
hold on
plot(xspace, nanmean(baselinePsychCurves), 'color', 'k')
hold on
%high prior
errorbar(bins, nanmean(highPriorNoNoisePsychBins), nanstd(highPriorNoNoisePsychBins)/sqrt(n), 'ro')
hold on
plot(xspace, nanmean(highPriorNoNoisePsychCurves), 'color', 'r')

box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
xlim([0 2.5])
ylim([0 1])