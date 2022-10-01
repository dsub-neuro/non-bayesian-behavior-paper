cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous')
%calls continuous_lineFits, continuous_respBins, continuous_SD_slopes
%% slopes fit to empirical data
respNoBins = NaN(11, 8);
respLowBins = NaN(11, 8);
respHighBins = NaN(11, 8);
respInfBins = NaN(11, 8);

pNo = NaN(11, 2);
pLow = NaN(11, 2);
pHigh = NaN(11, 2);
pInf = NaN(11, 2);

validParticipants = [1:2, 4, 6, 8:14];

for pNum = 1:length(validParticipants)
    participant = validParticipants(pNum);
    
    file = strcat('cleanData_', num2str(participant), '.mat');
    load(file)
    
    [respNoBins(pNum, :), respLowBins(pNum, :), respHighBins(pNum, :), respInfBins(pNum, :)] = continuous_respBins(testing, 0.5);
    [pNo(pNum, :), pLow(pNum, :), pHigh(pNum, :), pInf(pNum, :)] = continuous_lineFits(testing);
    
end

save('allSubBins.mat', 'respNoBins', 'respLowBins', 'respHighBins', 'respInfBins');
save('allSubLineFits.mat', 'pNo', 'pLow', 'pHigh', 'pInf');

%% slopes fit to model responses

load('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Continuous\fits_SSE_SD.mat')
pNoSD = NaN(11, 2);
pLowSD = NaN(11, 2);
pHighSD = NaN(11, 2);

validParticipants = [1:2, 4, 6, 8:14];

for pNum = 1:length(validParticipants)
    participant = validParticipants(pNum);
    
    file = strcat('cleanData_', num2str(participant), '.mat');
    load(file)
    
    [pNoSD(pNum, :), pLowSD(pNum, :), pHighSD(pNum, :)] = continuous_SD_slopes(testing, params.noNoiseSD(pNum), params.lowNoiseSD(pNum), params.highNoiseSD(pNum), params.priorMean(pNum), params.priorSD(pNum));
    
end

save('modelFitSD_slopes.mat', 'pNoSD', 'pLowSD', 'pHighSD');
