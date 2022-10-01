function [respNoBin, respLowBin, respHighBin, respInfBin] = continuous_respBins(testing, binSize)

degtopix = 49.7;
valid = ~isnan(testing.MouseX); 
testing = testing(valid, :);

priorMean = 0;
startTrial = 601;

mouseXJumpVal = testing.MouseX - (testing.Side*degtopix + testing.Targloc);
mouseXJump = mouseXJumpVal/degtopix; 

%get jump sizes, responses, isJump and noise values for testing trials
resp = mouseXJump(startTrial:end);
JS = (testing.JumpSize(startTrial:end)); 
noise = testing.Noise(startTrial:end); 
isJump = testing.isJump(startTrial:end);

%get rid of outliers greater than 4 standard deviations from the jump size
x = abs(JS - resp) > 4;
JS(x) = NaN;
resp(x) = NaN;
noise(x) = NaN;
isJump(x) = NaN;

%get noise level indices
noiseInf = isJump == 0;
noNoise = testing.isJump(startTrial:end) == 1 & noise ==  4.9700;
lowNoise = testing.isJump(startTrial:end) == 1 & noise == degtopix*0.5;
highNoise = testing.isJump(startTrial:end) == 1 & noise == degtopix*1;

%get jump sizes for each noise level
JSInf = JS(noiseInf)- priorMean ;
JSNo = JS(noNoise)- priorMean;
JSLow = JS(lowNoise)- priorMean;
JSHigh = JS(highNoise)- priorMean;

%get responses for each noise level
respInf = resp(noiseInf)- priorMean;
respNo = resp(noNoise)- priorMean;
respLow = resp(lowNoise)- priorMean;
respHigh = resp(highNoise)- priorMean;

%get deviation from the jump size
respInf = JSInf - respInf;
respNo = JSNo - respNo;
respLow = JSLow - respLow;
respHigh = JSHigh - respHigh;

%%
bins = -2:binSize:2;  
%discretize responses into bins. Bins start at -1.5 and end at 2. 
JSNoBin = discretize(JSNo, bins);
JSLowBin = discretize(JSLow, bins);
JSHighBin = discretize(JSHigh, bins);
JSInfBin = discretize(JSInf, bins);

respNoBin = NaN(1, length(bins)-1); 
respLowBin = NaN(1, length(bins)-1);
respHighBin = NaN(1, length(bins)-1);
respInfBin = NaN(1, length(bins)-1);

for ii = 1:length(bins)-1
    %ii = bins(jj);
    currNoBin = JSNoBin == ii;
    currLowBin = JSLowBin == ii;
    currHighBin = JSHighBin == ii;
    currInfBin = JSInfBin == ii;
   
    respNoBin(1, ii) = nanmean(respNo(currNoBin));
    respLowBin(1, ii) = nanmean(respLow(currLowBin));
    respHighBin(1, ii) = nanmean(respHigh(currHighBin));
    respInfBin(1, ii) = nanmean(respInf(currInfBin));

end

end
