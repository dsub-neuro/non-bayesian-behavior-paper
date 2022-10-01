function [pNoSD, pLowSD, pHighSD] = continuous_SD_slopes(testing, noNoiseSD, lowNoiseSD, highNoiseSD, priorMean, priorSD)
%params formatted with columns "noNoiseSD, lowNoiseSD, highNoiseSD,
%priorMean, priorSD"

degtopix = 49.7;
valid = ~isnan(testing.MouseX); 
testing = testing(valid, :);

startTrial = 601;

%get jump sizes, responses, isJump and noise values for testing trials
JS = (testing.JumpSize(startTrial:end)); 
noise = testing.Noise(startTrial:end); 

%get noise level indices
noNoise = testing.isJump(startTrial:end) == 1 & noise ==  4.9700;
lowNoise = testing.isJump(startTrial:end) == 1 & noise == degtopix*0.5;
highNoise = testing.isJump(startTrial:end) == 1 & noise == degtopix*1;

%get jump sizes for each noise level
JSNo = JS(noNoise);
JSLow = JS(lowNoise);
JSHigh = JS(highNoise);

%get responses for each noise level
[respNo, outputSD] = gaussProduct(JSNo, noNoiseSD, priorMean, priorSD);
[respLow, outputSD] = gaussProduct(JSLow, lowNoiseSD, priorMean, priorSD);
[respHigh, outputSD] = gaussProduct(JSHigh, highNoiseSD, priorMean, priorSD);

%get deviation from the jump size
respNoDev = JSNo - respNo;
respLowDev = JSLow - respLow;
respHighDev = JSHigh - respHigh;

%%
pNoSD = polyfit(JSNo, respNoDev, 1);
pLowSD = polyfit(JSLow, respLowDev, 1);
pHighSD = polyfit(JSHigh, respHighDev, 1);

end
