expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Noise experiment'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
names = {'JT', 'KR', 'MB', 'P2', 'P3', 'P4', 'P6', 'P7', 'P8'};
dates = {'18May2016', '16May2016', '19May2016', '14Sep2016', '16Sep2016', '03Nov2016', '07Nov2016', '06Jan2017', '13Jan2017'};


for pNum = 1:9 %loop through participants
    pFolder = strcat(expFolder, '\', names{pNum}, '_', dates{pNum}); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(names{pNum}, '_noiseData_', dates{pNum}, '.mat' );
    load(pFile); 
    
    noiseTable = [];
    
    nTrials = size(noise, 1);
    timeNoise = NaN(nTrials, 4000);
    xPosNoise = NaN(nTrials, 4000);
    yPosNoise = NaN(nTrials, 4000);
    PupDNoise = NaN(nTrials, 4000);
        
    trlInd = 1;
    for subFolder = 1:13 %loop through blocks
        subFolderName = strcat(pFolder, '\',  num2str(subFolder));
        if isfolder(subFolderName) %if there is a folder for the block
            blockDir = dir(subFolderName); %get directory details for the folder            
            if length(blockDir) > 2 %if the block folder is not empty
                currFileName = strcat(subFolderName, '\', 'P1', '_noise.txt');
                currTable = readtable(currFileName);
                
                noiseTable = [noiseTable; currTable]; 
               
                [time, xPos, yPos, PupD] = eyeFile_read(subFolderName, 'P3', 'noise');
                endIndex = (trlInd - 1) + size(time,1);
                if size(currTable , 1) == size(time,1)
                    timeNoise(trlInd:endIndex, :) = time;
                    xPosNoise(trlInd:endIndex, :) = xPos;
                    yPosNoise(trlInd:endIndex, :) = yPos;
                    PupDNoise(trlInd:endIndex, :) = PupD;
                else
                    error('Eye data and experiment data do not match')
                end
                trlInd = trlInd + size(time, 1);
            end
        end        
    end
    cd(pFolder)
    save('eyeData_noise.mat', 'timeNoise', 'xPosNoise', 'yPosNoise', 'PupDNoise')
    save(strcat(names{pNum}, '_noiseTable.mat'), 'noiseTable')

end