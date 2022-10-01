function [jumpSize, isJump, jProbNorm, weights, prior, noiseOut, PerceptronJProbNorm, BayesJProbNorm]  = simulate_combinedModel_parallel_human(noNoise, jumpDist, noJumpDist, learningRate, bayesWeight, nTrials)
%combines two parallel categorical output
%models: a Bayesian one and a perceptron, learning model
%Final binary output is the weighted combination of outputs from the
%Bayesian and Perceptron models

dataSize = nTrials;
%% set up Perceptron input and weight matrices
numUnits = 75; %75 jump size 
weights = NaN(2, numUnits * 3, nTrials);%[jumpWeights; noJumpWeights] x jump sizes x trial number;

inputWeights = ones(2, numUnits * 3) * 0.5; %[jumpWeights; noJumpWeights] x [lowPriorJumpSizes(1:40), highPriorJumpSizes(41:80)]. Initialize all weights at 0.5. 
deltaWeights = zeros(2, numUnits * 3);

PerceptronJProbNorm = NaN(dataSize, 1);
PerceptronNJProbNorm = NaN(dataSize, 1);

%% set up Bayesian data structures

BayesJProbNorm = NaN(dataSize, 1);
%% set up final output structures
    
jProbNorm = NaN(dataSize, 1);
isJump = NaN(dataSize, 1);
prior = NaN(dataSize, 1);
noiseOut = NaN(dataSize, 1);
jumpSize = NaN(dataSize, 1);

%% 
for ii = 1:dataSize
    % get trial parameters
     if ii <= 100
         priorVal = 0.5;
         noiseVal = noNoise;
     elseif ii > 100 && ii <= 700
         priorVal = 0.8;
         noiseProb = rand();
         if noiseProb < 0.7
             noiseVal = noNoise;
         elseif noiseProb < 0.85
             noiseVal = noNoise * 10;
         else
             noiseVal = noNoise * 20;
         end
     else
         priorVal = 0.2;
         noiseProb = rand();
         if noiseProb < 0.7
             noiseVal = noNoise;
         elseif noiseProb < 0.85
             noiseVal = noNoise * 10;
         else
             noiseVal = noNoise * 20;
         end
     end

    if noiseVal == noNoise
        thresh = priorVal;
    else 
        thresh = 0.5;
    end
    
    isJumpProb = rand();
    if isJumpProb < thresh
        currJump = abs(normrnd(0, jumpDist));
        currIsJump = 1;
    else
        currJump = abs(normrnd(0, noJumpDist));
        currIsJump = 0;
    end
    
    jumpSize(ii) = currJump;
    
    if currJump > 7.5
        currJump = 7.5;
    end
    
    isJump(ii) = currIsJump;
    prior(ii) = priorVal;
    noiseOut(ii) = noiseVal;
    
    %% perceptron output
    pd = makedist('Normal', 'mu', (currJump*10)+1, 'sigma', noiseVal);
    
    truncDist = truncate(pd, 0, numUnits);
    
    input = zeros(1, numUnits * 3);
    inputVals = cdf(truncDist, 1:numUnits) - cdf(truncDist, 0:(numUnits - 1));
    
    if priorVal == 0.2
        input(1:75) = inputVals;
    elseif priorVal == 0.5
        input(76:150) = inputVals;
    elseif priorVal == 0.8
        input(151:end) = inputVals;
    end
    
    input = input';
        
    output = (inputWeights * input);
 
    PerceptronJProbNorm(ii) = output(1)/(output(1) + output(2)); 
    PerceptronNJProbNorm(ii) = output(2)/(output(1) + output(2)); 
    
    if currIsJump == 1
       deltaWeights(1, 1:numUnits * 3) = (1 - PerceptronJProbNorm(ii)) * input;
    elseif currIsJump == 0
       deltaWeights(2, 1:numUnits * 3) = (1 - PerceptronNJProbNorm(ii)) * input;
    end
    
    inputWeights = inputWeights +  (learningRate .* deltaWeights);

    weights(:, :, ii) = inputWeights;
    
    %% get the Bayesian output on each trial
    
    BayesJProbNorm(ii) = bayes_decision_simulation(jumpSize(ii), jumpDist, noJumpDist*3, noNoise/10, priorVal);
    %note: noiseVal/10 = noise in degrees
    %% get the final output

    jProbNorm(ii) = (bayesWeight*BayesJProbNorm(ii)) + ((1 - bayesWeight)*PerceptronJProbNorm(ii)); 
end

end