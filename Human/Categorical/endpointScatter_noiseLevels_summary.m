clear all, close all
cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Categorical')

validParticipants = [1, 3, 4, 6:8, 10:20];

numPart = length(validParticipants);

noNoiseSD = NaN(numPart, 2); %X standard deviation, Y standard deviation
lowNoiseSD = NaN(numPart, 2); 
highNoiseSD = NaN(numPart, 2);

for participant = 1:numPart
    pNum = validParticipants(participant); 
    
    filename = strcat('cleanData_', num2str(pNum), '.mat'); %get file name by converting current loop index to a string and concatenating it to the rest of the file name
    load(filename)
    
    numTrials = length(xEnd);

    noise = TTraining.Noise;
    targLoc = TTraining.Side + TTraining.Targloc/21.5;
    
    xScatter = xEnd' - targLoc;
    yScatter = yEnd;
    
    noiseLevels = unique(noise);
    
    noNoise = noise == noiseLevels(1);
    lowNoise = noise == noiseLevels(2);
    highNoise = noise == noiseLevels(3);
    
    noNoiseSD(participant, 1) = std(xScatter(noNoise));
    lowNoiseSD(participant, 1) = std(xScatter(lowNoise));
    highNoiseSD(participant, 1) = std(xScatter(highNoise));
    
    noNoiseSD(participant, 2) = std(yEnd(noNoise));
    lowNoiseSD(participant, 2) = std(yEnd(lowNoise));
    highNoiseSD(participant, 2) = std(yEnd(highNoise));
    
end

variableNames = {'X', 'Y'};
noNoiseSD = array2table(noNoiseSD);
noNoiseSD.Properties.VariableNames = variableNames;

lowNoiseSD = array2table(lowNoiseSD);
lowNoiseSD.Properties.VariableNames = variableNames;

highNoiseSD = array2table(highNoiseSD);
highNoiseSD.Properties.VariableNames = variableNames;

save('endPointScatter_noiseLevels.mat', 'noNoiseSD', 'lowNoiseSD', 'highNoiseSD')
   
    