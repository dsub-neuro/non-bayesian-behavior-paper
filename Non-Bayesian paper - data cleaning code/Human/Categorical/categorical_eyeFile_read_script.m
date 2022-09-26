expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Categorical experiment - block'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
load('nameDate.mat')

for pNum = 1 %loop through participants
    pFolder = strcat(expFolder, '\', nameDate{1, pNum}, '_', nameDate{2, pNum}, '\Training'); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(nameDate{1, pNum}, '_training_', nameDate{2, pNum}, '.mat' );
    load(pFile);
    
    TTraining = [];
    
    nTrials = size(training, 1);
    timeTr = NaN(nTrials, 4000);
    xPosTr = NaN(nTrials, 4000);
    yPosTr = NaN(nTrials, 4000);
    PupDTr = NaN(nTrials, 4000);
        
    trlInd = 1;
    for subFolder = 1:13 %loop through blocks
        subFolderName = strcat(pFolder, '\',  num2str(subFolder));
        if isfolder(subFolderName) %if there is a folder for the block
            blockDir = dir(subFolderName); %get directory details for the folder            
            if length(blockDir) > 2 %if the block folder is not empty
                currFileName = strcat(subFolderName, '\', nameDate{1, pNum}, '_training', num2str(subFolder), '.txt');
                currTable = readtable(currFileName);
                
                TTraining = [TTraining; currTable]; 
               
                [time, xPos, yPos, PupD] = eyeFile_read(subFolderName, nameDate{1, pNum}, 'training');
                endIndex = (trlInd - 1) + size(time,1);
                if size(currTable , 1) == size(time,1)
                    timeTr(trlInd:endIndex, :) = time;
                    xPosTr(trlInd:endIndex, :) = xPos;
                    yPosTr(trlInd:endIndex, :) = yPos;
                    PupDTr(trlInd:endIndex, :) = PupD;
                else
                    error('Eye data and experiment data do not match')
                end
                trlInd = trlInd + size(time, 1);
            end
        end        
    end
    cd(pFolder)
    save('eyeData_training.mat', 'timeTr', 'xPosTr', 'yPosTr', 'PupDTr')
    save(strcat(names{pNum}, '_training_table.mat'), 'TTraining')

end