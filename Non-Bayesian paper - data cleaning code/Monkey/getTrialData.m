function [trialData, sessionData]  = getTrialData(sessionFolder, eyeCoil)
%returns trialData with time, X and Y eye position in degrees, and photodiode for each
%trial
%sessionFolder = folder containing rasterData files for each trial and a
%sessionData file 
%eyeCoil = which eye coil used for animal. 1 = left (Skwiz), 2 = right
%(Toki)
%isRecording = whether recording or behavioral version of task. 0 =
%behavioral, 1 = recording

%call sessionFolder to the current directory and get directory details
cd(sessionFolder)
d = dir(sessionFolder);
nTrials = length(d) - 3;

%set up trialData fields
trialData.time = NaN(nTrials, 12000);
trialData.XPos = NaN(nTrials, 12000);
trialData.YPos = NaN(nTrials, 12000);
trialData.Photodiode = NaN(nTrials, 12000); 

%get sessionDataFile and load it. If named "ssd_" then will be at the end
%after all rasterData files. If named "data_" then at the top
if strcmp(d(3).name, 'rasterData_1.mat')
    sessionDataFile = d(end).name;
else
    sessionDataFile = d(3).name;
end
sessionData = load(sessionDataFile);

degtopix = 24;

for trialNum = 1:nTrials
    rasterFile = strcat('rasterData_', num2str(trialNum), '.mat');
    load(rasterFile)
    fileLength = size(rasterData, 1);
    trialData.time(trialNum, 1:fileLength) = rasterData.Time;
    if eyeCoil == 1 %for Skwiz
        trialData.XPos(trialNum, 1:fileLength) = (rasterData.Eye_Position_X_1*100)/degtopix; %100 = gain used in krPeekEyePos 
        trialData.YPos(trialNum, 1:fileLength) = (rasterData.Eye_Position_Y_1*100)/degtopix; %100 = gain used in krPeekEyePos 
    elseif eyeCoil == 2 %for Toki
        trialData.XPos(trialNum, 1:fileLength) = (rasterData.Eye_Position_X_2*180)/degtopix; %180 = gain used in krPeekEyePos2 
        trialData.YPos(trialNum, 1:fileLength) = (rasterData.Eye_Position_Y_2*150)/degtopix; %150 = gain used in krPeekEyePos2 
    end
    trialData.Photodiode(trialNum, 1:fileLength) = rasterData.Photodiode;
end

end