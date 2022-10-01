function [jumpSize, isJump, jProbNorm, weights, prior, noiseOut] = simulate_perceptron_ssd_withPriorWithNoise_separateUnits(jumpDist, noJumpDist, nTrials, learningRate, noise)
%jumpDist = standard deviation of jump distribution
%noJumpDist = standard deviation of noJump distribution
%learning rate of perceptron model

numUnits = 75; %75 jump size 
weights = NaN(2, numUnits * 3, nTrials);%[jumpWeights; noJumpWeights] x jump sizes x trial number;

jProbNorm = NaN(nTrials, 1);
njProbNorm = NaN(nTrials, 1);

jumpSize = NaN(nTrials, 1); 
isJump = NaN(nTrials, 1);
prior = NaN(nTrials, 1);
noiseOut = NaN(nTrials, 1);

inputWeights = ones(2, numUnits * 3) * 0.5; %[jumpWeights; noJumpWeights] x [lowPriorJumpSizes(1:40), highPriorJumpSizes(41:80)]. Initialize all weights at 0.5. 
deltaWeights = zeros(2, numUnits * 3);

for ii = 1:nTrials    
     isJumpProb = rand(); 
     if ii <= 100
         priorVal = 0.5;
         noiseVal = noise;
     elseif ii > 100 && ii <=700
         priorVal = 0.8;
         noiseProb = rand();
         if noiseProb < 0.7
             noiseVal = noise;
         elseif noiseProb < 0.85
             noiseVal = noise * 10;
         else
             noiseVal = noise * 20;
         end
     else
         priorVal = 0.2;
         noiseProb = rand();
         if noiseProb < 0.7
             noiseVal = noise;
         elseif noiseProb < 0.85
             noiseVal = noise * 10;
         else
             noiseVal = noise * 20;
         end
     end

    if noiseVal == noise
        thresh = priorVal;
    else 
        thresh = 0.5;
    end
     
    if isJumpProb < thresh
        currJump = abs(normrnd(0, jumpDist));
        currIsJump = 1;
    else
        currJump = abs(normrnd(0, noJumpDist));
        currIsJump = 0;
    end
    
    jumpSize(ii) = currJump;

    currJump = round(currJump, 1); 

    if currJump > 7.5
        currJump = 7.5;
    end
    
    isJump(ii) = currIsJump;
    prior(ii) = priorVal;
    noiseOut(ii) = noiseVal; 

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
 
    jProbNorm(ii) = output(1)/(output(1) + output(2)); 
    njProbNorm(ii) = output(2)/(output(1) + output(2)); 

    if currIsJump == 1
       deltaWeights(1, 1:numUnits * 3) = (1 - jProbNorm(ii)) * input;
    elseif currIsJump == 0
       deltaWeights(2, 1:numUnits * 3) = (1 - njProbNorm(ii)) * input;
    end
    
    inputWeights = inputWeights +  (learningRate .* deltaWeights);
    
    weights(:, :, ii) = inputWeights;
    
end
end