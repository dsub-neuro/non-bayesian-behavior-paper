function err = bayesModel_monkey_withLapsesByNoise(data, coef)

dataSize = size(data.thresh, 1);

%% assign variables to parameters in coef


noNoise = coef(1);
lowNoise = coef(2);
highNoise = coef(3);
lowPriorLogOdds = coef(4);
medPriorLogOdds = coef(5);
highPriorLogOdds = coef(6);
noNoiseLowerBound = coef(7);
noNoiseLapse = coef(8);
lowNoiseLowerBound = coef(9);
lowNoiseLapse = coef(10);
highNoiseLowerBound = coef(11);
highNoiseLapse = coef(12);
noJumpWidth = coef(13);
jumpWidth = coef(14);
%% set up model output structures
jProbNorm = NaN(dataSize, 1);
njProbNorm = NaN(dataSize, 1);

resp = data.resp;

dataSize = size(data.thresh, 1);
%get low and high prior colors
colorInd = NaN(dataSize, 1);
highPriorThresh = data.thresh == 0.8;
highPriorColor = data.color(highPriorThresh, :);
highPriorColor = highPriorColor(1, :);

lowPriorThresh = data.thresh == 0.2;
lowPriorColor = data.color(lowPriorThresh, :);
lowPriorColor = lowPriorColor(1, :);

for ii = 1:length(colorInd)
    if data.color(ii, :) == highPriorColor
        colorInd(ii) = 3;
    elseif data.color(ii, :) == lowPriorColor
        colorInd(ii) = 2;
    else
        colorInd(ii) = 1;
    end
end

%get noise levels for the data
noiseLevels = unique(data.noise);

%% find model probability of responding "jump" on each trial

for trial = 1:dataSize

    if colorInd(trial) == 1
        priorOdds = medPriorLogOdds;
    elseif colorInd(trial) == 2
        priorOdds = lowPriorLogOdds;
    elseif colorInd(trial) == 3
        priorOdds = highPriorLogOdds;
    end

    if data.noise(trial) == noiseLevels(1)
        noise = noNoise;
        lowerBound = noNoiseLowerBound;
        lapse = noNoiseLapse;
    elseif data.noise(trial) == noiseLevels(2)
        noise = lowNoise;
        lowerBound = lowNoiseLowerBound;
        lapse = lowNoiseLapse;
    elseif data.noise(trial) == noiseLevels(3)
        noise = highNoise;
        lowerBound = highNoiseLowerBound;
        lapse = highNoiseLapse;
    end
    
    jumpSize = abs(data.jumpSize(trial));
        
    % return decision value for trial from simulation function
    jProbNorm(trial) = bayes_decision_simulation_lapses(jumpSize, jumpWidth, noJumpWidth, noise, priorOdds, lowerBound, lapse);
    njProbNorm(trial) = 1 - jProbNorm(trial);
    
end

jProbNorm0 = jProbNorm == 0;
jProbNorm(jProbNorm0) = 0.0001;
njProbNorm(jProbNorm0) = 0.9999;

njProbNorm0 = njProbNorm == 0;
njProbNorm(njProbNorm0) = 0.0001;
jProbNorm(njProbNorm0) = 0.9999;

pCr = resp.*jProbNorm + (1-resp).*njProbNorm;

err = -sum(log(pCr));

end