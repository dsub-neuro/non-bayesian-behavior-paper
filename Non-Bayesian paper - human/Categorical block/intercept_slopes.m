load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_allTrials2.mat')

xspace = linspace(0, 4, 10000);

noNoiseIntercepts = NaN(17, 3); %lowPrior, baseline, highPrior
lowNoiseIntercepts = NaN(17, 2); %lowPrior, highPrior
highNoiseIntercepts = NaN(17, 2); %lowPrior, highPrior

for pNum = 1:17
    noNoiseIntercepts(pNum, 1) = 1./(1+exp(-coefInt.lowPriorNoNoise(pNum)));
    noNoiseIntercepts(pNum, 2) = 1./(1+exp(-coefInt.baseline(pNum)));
    noNoiseIntercepts(pNum, 3) = 1./(1+exp(-coefInt.highPriorNoNoise(pNum)));

    lowNoiseIntercepts(pNum, 1) = 1./(1+exp(-coefInt.lowPriorLowNoise(pNum)));
    lowNoiseIntercepts(pNum, 2) = 1./(1+exp(-coefInt.highPriorLowNoise(pNum)));
    
    highNoiseIntercepts(pNum, 1) = 1./(1+exp(-coefInt.lowPriorHighNoise(pNum)));
    highNoiseIntercepts(pNum, 2) = 1./(1+exp(-coefInt.highPriorHighNoise(pNum)));
    
end

noNoiseIntercepts = array2table(noNoiseIntercepts, 'VariableNames', {'lowPrior', 'medPrior', 'highPrior'});
lowNoiseIntercepts = array2table(lowNoiseIntercepts, 'VariableNames', {'lowPrior', 'highPrior'});
highNoiseIntercepts = array2table(highNoiseIntercepts, 'VariableNames', {'lowPrior', 'highPrior'});

%% no noise intercepts

for ii = 1:17
    plot(1:3, [noNoiseIntercepts.lowPrior(ii), noNoiseIntercepts.medPrior(ii), noNoiseIntercepts.highPrior(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
end 
errorbar(1:3, [mean(noNoiseIntercepts.lowPrior), mean(noNoiseIntercepts.medPrior), mean(noNoiseIntercepts.highPrior)], [std(noNoiseIntercepts.lowPrior)/sqrt(17), std(noNoiseIntercepts.medPrior)/sqrt(17), std(noNoiseIntercepts.highPrior)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 3.2])
xticks([1 2 3])
xticklabels({'0.22', '0.5', '0.78'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)
 
 
 %% plot low and high noise intercept difference
 
 lowNoiseDiff = lowNoiseIntercepts.highPrior - lowNoiseIntercepts.lowPrior;
 highNoiseDiff = highNoiseIntercepts.highPrior - highNoiseIntercepts.lowPrior;
 
 for ii = 1:17
    plot(1:2, [lowNoiseDiff(ii), highNoiseDiff(ii)], 'o-', 'color', [0.7, 0.7, 0.7], 'MarkerSize', 2, 'LineWidth', 1)
    hold on
 end
errorbar(1:2, [mean(lowNoiseDiff), mean(highNoiseDiff)], [std(lowNoiseDiff)/sqrt(17), std(highNoiseDiff)/sqrt(17)], 'ko', 'MarkerSize', 10, 'LineWidth', 2)
xlim([0.8 2.2])
xticks([1 2])
xticklabels({'Low noise', 'High noise'})
box off
set(gca, 'LineWidth', 1.5, 'FontSize', 15)