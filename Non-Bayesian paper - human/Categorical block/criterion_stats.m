load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_allTrials.mat')
c = CriterionVals;

%% no noise
% test no noise criterions for normality
h = lillietest(c.baseline);
h = lillietest(c.lowPriorNoNoise);
h = lillietest(c.highPriorNoNoise);

% they are normally distributed. Run repeated measures ANOVA and compare adjacent values with paired t-tests. 

[p, table] = anova_rm([c.lowPriorNoNoise, c.baseline, c.highPriorNoNoise]); %F(2) = 22.2, p = 8.9738e-07
[h, p] = ttest(c.lowPriorNoNoise, c.baseline); %p = 0.0032
[h, p] = ttest(c.baseline, c.highPriorNoNoise); %p = 0.0013

%% low and high noise
% test low and high noise criterions for normality
h = lillietest(c.highPriorHighNoise);
h = lillietest(c.lowPriorHighNoise);
h = lillietest(c.lowPriorLowNoise);
h = lillietest(c.highPriorLowNoise);

%all normal 
lowNoiseDiff = c.lowPriorLowNoise - c.highPriorLowNoise;
highNoiseDiff = c.lowPriorHighNoise - c.highPriorHighNoise;

mean(lowNoiseDiff) % 0.5378
std(lowNoiseDiff)/sqrt(17) %0.1271

mean(highNoiseDiff) % 0.2141
std(highNoiseDiff)/sqrt(17) %0.1158

%test Criterion differences for normality
h = lillietest(lowNoiseDiff); %is normal
h = lillietest(highNoiseDiff); %is not normal

p = signrank(lowNoiseDiff, highNoiseDiff); %p = 0.0065
 


