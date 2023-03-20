%% generates Figures 5d and e
%5d; in sac
load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\inVsOppSac\allSubBins_inSac.mat')
%5e; opp sac
%load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\inVsOppSac\allSubBins_inSac.mat')

%binned response and linefit plots. 
binSize = 0.5;
bins = -1.75:binSize:1.75;  

% binned responses
noNoiseMean = nanmean(respNoBins);
noNoiseErr = nanstd(respNoBins)/sqrt(11);

lowNoiseMean = nanmean(respLowBins);
lowNoiseErr = nanstd(respLowBins)/sqrt(11);

highNoiseMean = nanmean(respHighBins);
highNoiseErr = nanstd(respHighBins)/sqrt(11);

infNoiseMean = nanmean(respInfBins);
infNoiseErr = nanstd(respInfBins)/sqrt(11);

figure
errorbar(bins, infNoiseMean, infNoiseErr, 'ro-', 'MarkerSize', 10, 'LineWidth', 2)
hold on
% shadedErrorBar(x, nanmean(pInfAll), nanstd(pInfAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', 'r'})
% hold on
errorbar(bins, highNoiseMean, highNoiseErr, 'o-', 'color', [0.6 0 1], 'MarkerSize', 10, 'LineWidth', 2)
hold on
% shadedErrorBar(x, nanmean(pHighAll), nanstd(pHighAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', [0.6 0 1]})
% hold on
errorbar(bins, lowNoiseMean, lowNoiseErr, 'o-', 'color', [0 0.5 0.5], 'MarkerSize', 10, 'LineWidth', 2)
hold on
% shadedErrorBar(x, nanmean(pLowAll), nanstd(pLowAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', [0 0.5 0.5]})
% hold on
errorbar(bins, noNoiseMean, noNoiseErr, 'ko-', 'MarkerSize', 10, 'LineWidth', 2)
hold on
%shadedErrorBar(x, nanmean(pNoAll), nanstd(pNoAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', 'k'})

box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylim([-2 2])


%% plot fit SDs from Bayesian model. Figure 5i. 
load(load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\withBiasFits_fixedPriorSD.mat')
figure
for pNum = 1:11
    plot(1:3, [params.noNoiseSD(pNum), params.lowNoiseSD(pNum), params.highNoiseSD(pNum)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end
errorbar(1:3, [nanmean(params.noNoiseSD), nanmean(params.lowNoiseSD), nanmean(params.highNoiseSD)], [nanstd(params.noNoiseSD)/sqrt(11), nanstd(params.lowNoiseSD)/sqrt(11), nanstd(params.highNoiseSD)/sqrt(11)], 'ko', 'LineWidth', 2, 'MarkerSize', 8)
box off
xlim([0.8 3.2])
xticks([1 2 3])
xticklabels({'No noise', 'Low noise', 'High noise'})
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% plot fit prior mean from Bayesian model. Figure 5j. 

figure
errorbar(1, mean(params.priorMean), std(params.priorMean)/sqrt(11), 'ko', 'MarkerSize', 10, 'LineWidth', 2)
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%% plot response vs. presented displacement (not deviation)
%Figure 5f
load(load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\negSubBins_notDev.mat')
load(load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\negSubLineFits_notDev.mat')

binSize = 0.5;
bins = -1.75:binSize:1.75;  

% binned responses
noNoiseMean = nanmean(respNoBins);
noNoiseErr = nanstd(respNoBins)/sqrt(11);

lowNoiseMean = nanmean(respLowBins);
lowNoiseErr = nanstd(respLowBins)/sqrt(11);

highNoiseMean = nanmean(respHighBins);
highNoiseErr = nanstd(respHighBins)/sqrt(11);

infNoiseMean = nanmean(respInfBins);
infNoiseErr = nanstd(respInfBins)/sqrt(11);

% line fits
x = linspace(-2, 2, 1000);
pInfAll = NaN(11, 1000);
pHighAll = NaN(11, 1000);
pLowAll = NaN(11, 1000);
pNoAll = NaN(11, 1000);

for ii = 1:11
pInfAll(ii,:) = pInf(ii, 1)*x + pInf(ii, 2);
pHighAll(ii,:) = pHigh(ii, 1)*x + pHigh(ii, 2);
pLowAll(ii,:) = pLow(ii, 1)*x + pLow(ii, 2);
pNoAll(ii,:) = pNo(ii, 1)*x + pNo(ii, 2);
end 

% plot both on same axes
figure
errorbar(bins, infNoiseMean, infNoiseErr, 'ro-', 'MarkerSize', 10, 'LineWidth', 2)
hold on
shadedErrorBar(x, nanmean(pInfAll), nanstd(pInfAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', 'r'})
hold on
errorbar(bins, highNoiseMean, highNoiseErr, 'o-', 'color', [0.6 0 1], 'MarkerSize', 10, 'LineWidth', 2)
hold on
shadedErrorBar(x, nanmean(pHighAll), nanstd(pHighAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', [0.6 0 1]})
hold on
errorbar(bins, lowNoiseMean, lowNoiseErr, 'o-', 'color', [0 0.5 0.5], 'MarkerSize', 10, 'LineWidth', 2)
hold on
shadedErrorBar(x, nanmean(pLowAll), nanstd(pLowAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', [0 0.5 0.5]})
hold on
errorbar(bins, noNoiseMean, noNoiseErr, 'ko-', 'MarkerSize', 10, 'LineWidth', 2)
hold on
shadedErrorBar(x, nanmean(pNoAll), nanstd(pNoAll)./sqrt(11), 'lineProps', {'LineWidth', 2, 'color', 'k'})

box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylim([-2 2])


