load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Noise experiment\noise_summary_data.mat')

%% blob

d = blob.DPrime;

%test d' for normality
h = lillietest(d.highNoise);
h = lillietest(d.lowNoise);

%both normal. Compare using parametric t-test.
mean(d.lowNoise); %2.084331155241721
std(d.lowNoise)/sqrt(9); %0.145409390303919

mean(d.highNoise); %    1.6189
std(d.highNoise)/sqrt(9); %0.1439


[h, p] = ttest(d.highNoise, d.lowNoise); %p = 0.0023
