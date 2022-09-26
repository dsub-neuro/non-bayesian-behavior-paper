expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Continuous experiment'; %switch to Continuous Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
load('nameDate.mat')

for pNum = 11 %loop through participants
    pFolder = strcat(expFolder, '\', nameDate{1, pNum}, '_', nameDate{2, pNum}); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(nameDate{1, pNum}, '_testing_table.mat' );
    load(pFile);
    
    nTrials = size(testing, 1);
    timeTe = NaN(nTrials, 4000);
    xPosTe = NaN(nTrials, 4000);
    yPosTe = NaN(nTrials, 4000);
    PupDTe = NaN(nTrials, 4000);
    
    testing = [];
    trlInd = 1;
    for subFolder = 1:13 %loop through blocks
        subFolderName = strcat(pFolder, '\',  num2str(subFolder));
        if isfolder(subFolderName) %if there is a folder for the block
            blockDir = dir(subFolderName); %get directory details for the folder            
            if length(blockDir) > 2 %if the block folder is not empty
                currFileName = strcat(subFolderName, '\', nameDate{1, pNum}, '_testing', num2str(subFolder), '.txt');
                currTable = readtable(currFileName);
                
                testing = [testing; currTable]; 
               
                [time, xPos, yPos, PupD] = eyeFile_read(subFolderName, nameDate{1, pNum}, 'testing');
                endIndex = (trlInd - 1) + size(time,1);
                if size(currTable , 1) == size(time,1)
                    timeTe(trlInd:endIndex, :) = time;
                    xPosTe(trlInd:endIndex, :) = xPos;
                    yPosTe(trlInd:endIndex, :) = yPos;
                    PupDTe(trlInd:endIndex, :) = PupD;
                else
                    error('Eye data and experiment data do not match')
                end
                trlInd = trlInd + size(time, 1);
            end
        end        
    end
    cd(pFolder)
    save('eyeData_testing.mat', 'timeTe', 'xPosTe', 'yPosTe', 'PupDTe')
    save(strcat(nameDate{1, pNum}, '_testing_table.mat'), 'testing')

end