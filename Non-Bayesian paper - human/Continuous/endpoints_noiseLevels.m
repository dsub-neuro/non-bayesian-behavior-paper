endpoints_x = NaN(11, 4);
endpoints_y = NaN(11, 4);

validParticipants = [1:2, 4, 6, 8:14];

degtopix = 49.7;
for pNum = 1:length(validParticipants)
    participant = validParticipants(pNum);
    
    file = strcat('cleanData_', num2str(participant), '.mat');
    load(file)
    
    startTrial = 601;

    targLoc = testing.Side + testing.Targloc/49.7;

    targLoc = targLoc(startTrial:end);
    noise = testing.Noise(startTrial:end);
    isJump = testing.isJump(startTrial:end);
    xEnd = xEnd(startTrial:end);
    xScatter = xEnd' - targLoc;
    yScatter = yEnd(startTrial:end);
    
    %get noise level indices
    noiseInf = isJump == 0;
    noNoise = testing.isJump(startTrial:end) == 1 & noise ==  4.9700;
    lowNoise = testing.isJump(startTrial:end) == 1 & noise == degtopix*0.5;
    highNoise = testing.isJump(startTrial:end) == 1 & noise == degtopix*1;

    endpoints_x(pNum, 1) = nanstd(xScatter(noNoise));
    endpoints_x(pNum, 2) = nanstd(xScatter(lowNoise));
    endpoints_x(pNum, 3) = nanstd(xScatter(highNoise));
    endpoints_x(pNum, 4) = nanstd(xScatter(noiseInf));
    
    endpoints_y(pNum, 1) = nanstd(yScatter(noNoise));
    endpoints_y(pNum, 2) = nanstd(yScatter(lowNoise));
    endpoints_y(pNum, 3) = nanstd(yScatter(highNoise));
    endpoints_y(pNum, 4) = nanstd(yScatter(noiseInf));
    
end