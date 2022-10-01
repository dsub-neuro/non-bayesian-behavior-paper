function err = continuous_bayes_sse(testing, coef)

%% assign variables to coef

noNoiseSD = coef(1);
lowNoiseSD = coef(2);
highNoiseSD = coef(3);
priorMean = coef(4);
priorSD = coef(5);

%% set up structures for model outputs
dataSize = size(testing, 1);
respModel = NaN(dataSize, 1);

%% get true response from data
degtopix = 49.7;
mouseXJumpVal = testing.MouseX - (testing.Side*degtopix + testing.Targloc);
resp = mouseXJumpVal/degtopix; 

%% get model response for each trial

for trial = 1:dataSize
    
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
    
    %get jumpSize on current trial
    jumpSize = testing.JumpSize(trial);
    
    [respModel(trial), respSD] = gaussProduct(jumpSize, noiseSD, priorMean, priorSD);
    
end

diff = respModel - resp;
err = sum(diff .^ 2);

end