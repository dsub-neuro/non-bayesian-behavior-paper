%% generates bootstrap data in the perceptron and combined models
%calls the following functions
%simulate_perceptron_ssd_withPriorWithNoise_separateUnits --> perceptron
%early training
%

clear
clc

%% set up parameters for early training simulations
params.jumpDist = 2.5;
params.noJumpDist = 0.5;
params.humanTrials = 1300;
params.learningRate = 0.5;
params.noNoise = 1;
params.bayesWeight = 0.1; 

params.lowNoise = 10;
params.highNoise = 20;

%% perceptron only early training
jumpSizePEarly = NaN(10000, 1300);
jProbNormPEarly = NaN(10000, 1300);
priorPEarly = NaN(10000, 1300);
noiseOutPEarly = NaN(10000, 1300);

for ii = 1:10000
    [jumpSizePEarly(ii, :), ~, jProbNormPEarly(ii, :), ~, priorPEarly(ii, :), noiseOutPEarly(ii, :)] = simulate_perceptron_ssd_withPriorWithNoise_separateUnits(params.jumpDist, params.noJumpDist, params.humanTrials, params.learningRate, params.noNoise);
end

%% save perceptron only early data
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Simulations\Bootstrap perceptron and combined')
save('perceptronOnlyEarly_bootstrapData', 'jumpSizePEarly', 'jProbNormPEarly', 'priorPEarly', 'noiseOutPEarly', 'params')

%% combined early
jumpSizeCEarly = NaN(10000, 1300);
jProbNormCEarly = NaN(10000, 1300);
priorCEarly = NaN(10000, 1300);
noiseOutCEarly = NaN(10000, 1300);

for ii = 1:10000
    [jumpSizeCEarly(ii, :), ~, jProbNormCEarly(ii, :), ~, priorCEarly(ii, :), noiseOutCEarly(ii, :), ~, ~]  = simulate_combinedModel_parallel_human(params.noNoise, params.jumpDist, params.noJumpDist, params.learningRate, params.bayesWeight, params.humanTrials);
end

%% save combined early data
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Simulations\Bootstrap perceptron and combined')
save('combinedEarly_bootstrapData', 'jumpSizeCEarly', 'jProbNormCEarly', 'priorCEarly', 'noiseOutCEarly', 'params')

%% perceptron only late
jumpSizePLate = NaN(10000, 5000);
jProbNormPLate = NaN(10000, 5000);
priorPLate = NaN(10000, 5000);
noiseOutPLate = NaN(10000, 5000);

params.nTrials = 5000;

for ii = 3178:10000
    disp(ii)
    [jumpSizePLate(ii, :), ~, jProbNormPLate(ii, :), ~, priorPLate(ii, :), noiseOutPLate(ii, :)] = simulate_perceptron_ssd_separateUnits(params.jumpDist, params.noJumpDist, params.nTrials, params.learningRate, params.noNoise);
end

%% save perceptron only late data
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Simulations\Bootstrap perceptron and combined')
save('perceptronOnlyLate_bootstrapData', 'jumpSizePLate', 'jProbNormPLate', 'priorPLate', 'noiseOutPLate', 'params')

%% combined late
jumpSizeCLate = NaN(10000, 5000);
jProbNormCLate = NaN(10000, 5000);
priorCLate = NaN(10000, 5000);
noiseOutCLate = NaN(10000, 5000);

for ii = 1:10000
    [jumpSizeCLate(ii, :), ~, jProbNormCLate(ii, :), ~, priorCLate(ii, :), noiseOutCLate(ii, :), ~, ~]  = simulate_combinedModel_parallel(params.noNoise, params.jumpDist, params.noJumpDist, params.learningRate, params.bayesWeight, params.nTrials);
end
%% save perceptron only late data
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Simulations\Bootstrap perceptron and combined')
save('combinedLate_bootstrapData', 'jumpSizeCLate', 'jProbNormCLate', 'priorCLate', 'noiseOutCLate', 'params')

%% noise only combined
jumpSizeLowNoise = NaN(10000, 100);
jProbNormLowNoise = NaN(10000, 100);

jumpSizeHighNoise = NaN(10000, 100);
jProbNormHighNoise = NaN(10000, 100);

for ii = 1:10000
    [jumpSizeLowNoise(ii, :), ~, jProbNormLowNoise(ii, :), ~, ~, ~, ~, ~]  = simulate_combinedModel_noiseOnly(1, params.jumpDist, params.noJumpDist, params.learningRate, params.bayesWeight, 100);
    [jumpSizeHighNoise(ii, :), ~, jProbNormHighNoise(ii, :), ~, ~, ~, ~, ~]  = simulate_combinedModel_noiseOnly(10, params.jumpDist, params.noJumpDist, params.learningRate, params.bayesWeight, 100);
end

%% 

cd('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Simulations\Perceptron')
save('combined_noiseOnly_2.mat', 'jumpSizeLowNoise', 'jProbNormLowNoise', 'jumpSizeHighNoise', 'jProbNormHighNoise')

