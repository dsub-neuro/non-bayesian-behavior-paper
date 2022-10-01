%% generates continuous experiment data and model figures in Figures 5e-i. 
load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\fits_SSE_SD.mat')
load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\allSubLineFits.mat')
load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\modelFitSD_slopes.mat')
load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\allSubBins.mat')

%% binned response and linefit plots. Figure 5e.
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
errorbar(bins, infNoiseMean, infNoiseErr, 'ro', 'MarkerSize', 6, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(pInfAll), nanstd(pInfAll)./sqrt(11), 'lineProps', 'r')
hold on
errorbar(bins, highNoiseMean, highNoiseErr, 'mo', 'MarkerSize', 6, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(pHighAll), nanstd(pHighAll)./sqrt(11), 'lineProps', 'm')
hold on
errorbar(bins, lowNoiseMean, lowNoiseErr, 'bo', 'MarkerSize', 6, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(pLowAll), nanstd(pLowAll)./sqrt(11), 'lineProps', 'b')
hold on
errorbar(bins, noNoiseMean, noNoiseErr, 'ko', 'MarkerSize', 6, 'LineWidth', 1)
hold on
shadedErrorBar(x, nanmean(pNoAll), nanstd(pNoAll)./sqrt(11), 'lineProps', 'k')

box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
ylim([-2 2])

%% plot fit slopes. Figure 5f.
figure
for pNum = 1:11
    plot(1:4, [pNo(pNum, 1), pLow(pNum, 1), pHigh(pNum, 1), pInf(pNum, 1)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end
errorbar(1:4, [nanmean(pNo(:, 1)), nanmean(pLow(:, 1)), nanmean(pHigh(:, 1)), nanmean(pInf(:, 1))], [nanstd(pNo(:, 1))/sqrt(11), nanstd(pLow(:, 1))/sqrt(11), nanstd(pHigh(:, 1))/sqrt(11), nanstd(pInf(:, 1))/sqrt(11)], 'ko', 'LineWidth', 2, 'MarkerSize', 8)
box off
xlim([0.8 4.2])
xticks([1 2 3 4])
xticklabels({'No noise', 'Low noise', 'High noise', 'Infinite noise'})
set(gca, 'LineWidth', 1.5, 'FontSize', 15)

%% plot model fits. Figure 5g. 
xspace = linspace(-2, 2, 10000);
priorDists = NaN(11, 10000);
noNoiseDists = NaN(11, 10000);
lowNoiseDists = NaN(11, 10000);
highNoiseDists = NaN(11, 10000);

for ii = 1:11
    priorDists(ii, :) = normpdf(xspace, params.priorMean(ii), params.priorSD(ii));
    noNoiseDists(ii, :) = normpdf(xspace, 1, params.noNoiseSD(ii));
    lowNoiseDists(ii, :) = normpdf(xspace, 1, params.lowNoiseSD(ii));
    highNoiseDists(ii, :) = normpdf(xspace, 1, params.highNoiseSD(ii));
end

figure
shadedErrorBar(xspace, nanmean(priorDists), nanstd(priorDists)/sqrt(11), 'lineProps', 'r')
hold on
shadedErrorBar(xspace, nanmean(noNoiseDists), nanstd(noNoiseDists)/sqrt(11), 'lineProps', 'k')
hold on
shadedErrorBar(xspace, nanmean(lowNoiseDists), nanstd(lowNoiseDists)/sqrt(11), 'lineProps', 'b')
hold on
shadedErrorBar(xspace, nanmean(highNoiseDists), nanstd(highNoiseDists)/sqrt(11), 'lineProps', 'm')
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')


%% plot fit SDs from Bayesian model. Figure 5h. 
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

%% plot SD-driven slopes vs. empirical slopes. Figure 5i. 

plot(pNoSD(:, 1), pNo(:, 1), 'ko')
hold on
plot(pLowSD(:, 1), pLow(:, 1), 'bo')
hold on
plot(pHighSD(:, 1), pHigh(:, 1), 'mo')
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')

%get correlation coefficient between them
emp = [pNo(:, 1); pLow(:, 1); pHigh(:, 1)];
model = [pNoSD(:, 1); pLowSD(:, 1); pHighSD(:, 1)];
[r, p] = corrcoef(model, emp);

