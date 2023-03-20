function err = continuous_bayes_inVsOppSac_bias_sse(testing, coef)

%% assign variables to coef

noNoiseSD = coef(1);
lowNoiseSD = coef(2);
highNoiseSD = coef(3);
priorMean = coef(4);
%priorSD = coef(5);

%% set up structures for model outputs
dataSize = size(testing, 1);
respModel = NaN(dataSize, 1);

%% get true response from data
degtopix = 49.7;
mouseXJumpVal = testing.MouseX - (testing.Side*degtopix + testing.Targloc);
resp = mouseXJumpVal/degtopix; 

%% get model response for each trial

for trial = 1:dataSize
    
    side = testing.Side(trial);
    jumpSize = testing.JumpSize(trial);

    if side > 0 %right saccade, prior compressed slightly to the left
        priorMean = -priorMean;
    end

    %get noise level
    if testing.isJump(trial) == 1 && testing.Noise(trial) == 4.9700
        noiseSD = noNoiseSD;
    elseif testing.isJump(trial) == 1 && testing.Noise(trial) == degtopix * 0.5 
        noiseSD = lowNoiseSD;
    elseif testing.isJump(trial) == 1 && testing.Noise(trial) == degtopix
        noiseSD = highNoiseSD;
    elseif testing.isJump(trial) == 0
        noiseSD = Inf;
    end   

    if noiseSD == Inf
        respModel(trial) = 0;
    else
        [respModel(trial), ~] = gaussProduct(jumpSize, noiseSD, priorMean, 1);
    end
end

diff = respModel - resp;
err = sum(diff .^ 2);

end