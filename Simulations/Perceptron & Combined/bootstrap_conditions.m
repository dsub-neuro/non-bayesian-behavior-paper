%% cd data folder where bootstrap perceptron and combined data are stored.
%locally: C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Simulations\Bootstrap perceptron and combined
%same script run for all 4 simulation experiments: perceptron only early,
%combined early, perceptron only late, and combined late

%be sure to edit which variables are being called and the ranges of trials

%% edit variable names depending on which simulation is being run
jumpSize = jumpSizePLate;
resp = jProbNormPLate;
prior = priorPLate;
noise = noiseOutPLate;

%% set up data structures
%curves
%no noise
curves.baseline = NaN(10000, 1000);
curves.lowPriorNoNoise = NaN(10000, 1000);
curves.highPriorNoNoise = NaN(10000, 1000);

%low noise
curves.lowPriorLowNoise = NaN(10000, 1000);
curves.highPriorLowNoise = NaN(10000, 1000);

%high noise
curves.lowPriorHighNoise = NaN(10000, 1000);
curves.highPriorHighNoise = NaN(10000, 1000);

%bins
%no noise
bins.baseline = NaN(10000, 10);
bins.lowPriorNoNoise = NaN(10000, 10);
bins.highPriorNoNoise = NaN(10000, 10);

%low noise
bins.lowPriorLowNoise = NaN(10000, 10);
bins.highPriorLowNoise = NaN(10000, 10);

%high noise
bins.lowPriorHighNoise = NaN(10000, 10);
bins.highPriorHighNoise = NaN(10000, 10);

%min
%no noise
min.baseline = NaN(10000, 1);
min.lowPriorNoNoise = NaN(10000, 1);
min.highPriorNoNoise = NaN(10000, 1);

%low noise
min.lowPriorLowNoise = NaN(10000, 1);
min.highPriorLowNoise = NaN(10000, 1);

%high noise
min.lowPriorHighNoise = NaN(10000, 1);
min.highPriorHighNoise = NaN(10000, 1);

%% get data for each condition 
xspace = linspace(0, 5, 1000);

for ii = 1:10000
    % for late stage training, either perceptron only or combined
    currJS = jumpSize(ii, 3001:5000)';
    currResp = resp(ii, 3001:5000)';
    currPrior = prior(ii, 3001:5000)';
    currNoise = noise(ii, 3001:5000)';
    
%     % for early training
%     currJS = jumpSize(ii, :)';
%     currResp = resp(ii, :)';
%     currPrior = prior(ii, :)';
%     currNoise = noise(ii, :)';

    noiseLevels = unique(currNoise);
    noNoise = currNoise == noiseLevels(1);
    lowNoise = currNoise == noiseLevels(2);
    highNoise = currNoise == noiseLevels(3);

    lowPrior = currPrior == 0.2;
    medPrior = currPrior == 0.5;
    highPrior = currPrior == 0.8;
    
    %min and curves
    [min.baseline(ii), ~, ~, ~, curves.baseline(ii, :), ~] = psychCurve_4P(currJS(medPrior & noNoise), currResp(medPrior & noNoise), xspace);
    [min.lowPriorNoNoise(ii), ~, ~, ~, curves.lowPriorNoNoise(ii, :), ~] = psychCurve_4P(currJS(lowPrior & noNoise), currResp(lowPrior & noNoise), xspace);
    [min.highPriorNoNoise(ii), ~, ~, ~, curves.highPriorNoNoise(ii, :), ~] = psychCurve_4P(currJS(highPrior & noNoise), currResp(highPrior & noNoise), xspace);
    
    [min.lowPriorLowNoise(ii), ~, ~, ~, curves.lowPriorLowNoise(ii, :), ~] = psychCurve_4P(currJS(lowPrior & lowNoise), currResp(lowPrior & lowNoise), xspace);
    [min.highPriorLowNoise(ii), ~, ~, ~, curves.highPriorLowNoise(ii, :), ~] = psychCurve_4P(currJS(highPrior & lowNoise), currResp(highPrior & lowNoise), xspace);
    
    [min.lowPriorHighNoise(ii), ~, ~, ~, curves.lowPriorHighNoise(ii, :), ~] = psychCurve_4P(currJS(lowPrior & highNoise), currResp(lowPrior & highNoise), xspace);
    [min.highPriorHighNoise(ii), ~, ~, ~, curves.highPriorHighNoise(ii, :), ~] = psychCurve_4P(currJS(highPrior & highNoise), currResp(highPrior & highNoise), xspace);
    
    %0.5deg 
    bins.baseline(ii, :) = psychCurveBins_nonBinary(currJS(medPrior & noNoise), currResp(medPrior & noNoise), 0.5, 5);
    bins.lowPriorNoNoise(ii, :) = psychCurveBins_nonBinary(currJS(lowPrior & noNoise), currResp(lowPrior & noNoise), 0.5, 5);
    bins.highPriorNoNoise(ii, :) = psychCurveBins_nonBinary(currJS(highPrior & noNoise), currResp(highPrior & noNoise), 0.5, 5);
    
    bins.lowPriorLowNoise(ii, :) = psychCurveBins_nonBinary(currJS(lowPrior & lowNoise), currResp(lowPrior & lowNoise), 0.5, 5);
    bins.highPriorLowNoise(ii, :) = psychCurveBins_nonBinary(currJS(highPrior & lowNoise), currResp(highPrior & lowNoise), 0.5, 5);
    
    bins.lowPriorHighNoise(ii, :) = psychCurveBins_nonBinary(currJS(lowPrior & highNoise), currResp(lowPrior & highNoise), 0.5, 5);
    bins.highPriorHighNoise(ii, :) = psychCurveBins_nonBinary(currJS(highPrior & highNoise), currResp(highPrior & highNoise), 0.5, 5);
    
end

%% cd to save location and save
%locally goes to cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Simulations\Bootstrap perceptron and combined\Experimental conditions')
%locally save('perceptron_late_expConditions.mat', 'curves', 'bins', 'min')