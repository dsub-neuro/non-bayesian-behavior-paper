resultsFolder = 'C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Noise experiment';
cd(resultsFolder)

load('noise_summary_4P.mat')
nSubjects = 9;
xSpace = linspace(0, 4, 10000);
bins = 0:0.25:3.75;

%% cloud
cloudLowNoiseCurves = NaN(nSubjects, 10000);
cloudHighNoiseCurves = NaN(nSubjects, 10000);

for ii = 1:nSubjects
    cloudLowNoiseCurves(ii, :) = cloud.lowNoise(ii).curves;
    cloudHighNoiseCurves(ii, :) = cloud.highNoise(ii).curves;
end
%figure 1: cloud psychometric curves
figure
shadedErrorBar(xSpace, nanmean(cloudLowNoiseCurves), nanstd(cloudLowNoiseCurves)./sqrt(nSubjects), 'lineProps', 'k')
hold on
shadedErrorBar(xSpace, nanmean(cloudHighNoiseCurves), nanstd(cloudHighNoiseCurves)./sqrt(nSubjects), 'lineProps', 'r')
hold on
ylim([0 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',2)
yticks([0 0.25 0.5 0.75 1])

%figure 2: cloud d'
figure
errorbar(1:2, [nanmean(cloud.DPrime.lowNoise) nanmean(cloud.DPrime.highNoise)], [nanstd(cloud.DPrime.lowNoise)/sqrt(nSubjects) nanstd(cloud.DPrime.highNoise)/sqrt(nSubjects)], 'ko', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', [0.9 0.9 0.9])
xlim([0.8 2.2])
ylim([1.3 2.5])
xticks([1 2])
xticklabels({'Low Noise (SD = 0.0625)', 'High Noise (SD = 0.25)'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)

%% arrow
arrowLowNoiseCurves = NaN(nSubjects, 10000);
arrowHighNoiseCurves = NaN(nSubjects, 10000);

for ii = 1:nSubjects
    arrowLowNoiseCurves(ii, :) = arrow.lowNoise(ii).curves;
    arrowHighNoiseCurves(ii, :) = arrow.highNoise(ii).curves;
end
%figure 1: arrow psychometric curves
figure
shadedErrorBar(xSpace, nanmean(arrowLowNoiseCurves), nanstd(arrowLowNoiseCurves)./sqrt(nSubjects), 'lineProps', 'k')
hold on
shadedErrorBar(xSpace, nanmean(arrowHighNoiseCurves), nanstd(arrowHighNoiseCurves)./sqrt(nSubjects), 'lineProps', 'r')
hold on
ylim([0 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',2)
yticks([0 0.25 0.5 0.75 1])

%figure 2: arrow d'
figure
errorbar(1:2, [nanmean(arrow.DPrime.lowNoise) nanmean(arrow.DPrime.highNoise)], [nanstd(arrow.DPrime.lowNoise)/sqrt(nSubjects) nanstd(arrow.DPrime.highNoise)/sqrt(nSubjects)], 'ko', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', [0.9 0.9 0.9])
xlim([0.8 2.2])
xticks([1 2])
ylim([1.3 2.5])
xticklabels({'Low Noise (Congruent)', 'High Noise (Incongruent)'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)

%% contrast
contrastLowNoiseCurves = NaN(nSubjects, 10000);
contrastHighNoiseCurves = NaN(nSubjects, 10000);

for ii = 1:nSubjects
    contrastLowNoiseCurves(ii, :) = contrast.lowNoise(ii).curves;
    contrastHighNoiseCurves(ii, :) = contrast.highNoise(ii).curves;
end
%figure 1: contrast psychometric curves
figure
shadedErrorBar(xSpace, nanmean(contrastLowNoiseCurves), nanstd(contrastLowNoiseCurves)./sqrt(nSubjects), 'lineProps', 'k')
hold on
shadedErrorBar(xSpace, nanmean(contrastHighNoiseCurves), nanstd(contrastHighNoiseCurves)./sqrt(nSubjects), 'lineProps', 'r')
hold on
ylim([0 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',2)
yticks([0 0.25 0.5 0.75 1])

%figure 2: contrast d'
figure
errorbar(1:2, [nanmean(contrast.DPrime.lowNoise) nanmean(contrast.DPrime.highNoise)], [nanstd(contrast.DPrime.lowNoise)/sqrt(nSubjects) nanstd(contrast.DPrime.highNoise)/sqrt(nSubjects)], 'ko', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerFaceColor', [0.9 0.9 0.9])
xlim([0.8 2.2])
xticks([1 2])
ylim([1.3 2.5])
xticklabels({'Low Noise (0.784)', 'High Noise (0.294)'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)

%% blob
blobLowNoiseCurves = NaN(nSubjects, 10000);
blobHighNoiseCurves = NaN(nSubjects, 10000);

for ii = 1:nSubjects
    blobLowNoiseCurves(ii, :) = blob.lowNoise(ii).curves;
    blobHighNoiseCurves(ii, :) = blob.highNoise(ii).curves;
end
%figure 1: blob psychometric curves
figure
errorbar(bins, nanmean(blob.lowNoiseBins), nanstd(blob.lowNoiseBins)/sqrt(9), 'ko', 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(xSpace, nanmean(blobLowNoiseCurves), nanstd(blobLowNoiseCurves)./sqrt(nSubjects), 'lineProps', 'k')
hold on
errorbar(bins, nanmean(blob.highNoiseBins), nanstd(blob.highNoiseBins)/sqrt(9), 'ro', 'MarkerSize', 8, 'LineWidth', 1)
hold on
shadedErrorBar(xSpace, nanmean(blobHighNoiseCurves), nanstd(blobHighNoiseCurves)./sqrt(nSubjects), 'lineProps', 'r')
hold on
ylim([0 1])
xlim([0 2.5])
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',2)
yticks([0 0.25 0.5 0.75 1])
%% 
%figure 2: blob d'
figure
for ii = 1:nSubjects
    plot(1:2, [blob.DPrime.lowNoise(ii), blob.DPrime.highNoise(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end
errorbar(1:2, [nanmean(blob.DPrime.lowNoise) nanmean(blob.DPrime.highNoise)], [nanstd(blob.DPrime.lowNoise)/sqrt(nSubjects) nanstd(blob.DPrime.highNoise)/sqrt(nSubjects)], 'ko', 'LineWidth', 2, 'MarkerSize', 10)
xlim([0.8 2.2])
xticks([1 2])
%ylim([1.3 2.5])
xticklabels({'Low Noise (SD = 0.19)', 'High Noise (SD = 0.47)'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)



