data = CriterionVals;

noNoiseDiff = data.lowPriorNoNoise - data.highPriorNoNoise;
lowNoiseDiff = data.lowPriorLowNoise - data.highPriorLowNoise;
highNoiseDiff = data.lowPriorHighNoise - data.highPriorHighNoise;

figure
errorbar(1:3, [mean(noNoiseDiff), mean(lowNoiseDiff), mean(highNoiseDiff)], [std(noNoiseDiff)/sqrt(17), std(lowNoiseDiff)/sqrt(17), std(highNoiseDiff)/sqrt(17)], 'ko', 'MarkerSize', 15)
xlim([0.8 3.2])
xticks([1 2 3])
xticklabels({'No noise','Low noise','High noise'})
ylabel('Difference in intercepts (0.9 - 0.1)')

figure
plot(1:3, [noNoiseDiff, lowNoiseDiff, highNoiseDiff], 'ko')
xlim([0.8 3.2])
xticks([1 2 3])
xticklabels({'No noise','Low noise','High noise'})
ylabel('Difference in Criterion (0.1 - 0.9)')
