clear all, close all
load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\nameDate.mat');

validParticipants = [1, 3, 4, 6:8, 10:20];

numPart = length(validParticipants);

noNoiseSD = NaN(numPart, 2); %X standard deviation, Y standard deviation
lowNoiseSD = NaN(numPart, 2); 
highNoiseSD = NaN(numPart, 2);

for participant = 1:numPart
    pNum = validParticipants(participant); 
    
    folder = strcat('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\', nameDate{1, pNum}, '_', nameDate{2, pNum}, '\Training');
    cd(folder)
    
    load('sac_endpoints.mat');
    load('cleanData.mat');
    
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

    
   
    