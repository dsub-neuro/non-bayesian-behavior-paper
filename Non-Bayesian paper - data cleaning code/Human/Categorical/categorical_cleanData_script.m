expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Categorical experiment - block'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
load('nameDate.mat')

cleanRatio = NaN(20, 1);
for pNum = 1:20 %loop through participants
    pFolder = strcat(expFolder, '\', nameDate{1, pNum}, '_', nameDate{2, pNum}, '\Training'); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(nameDate{1, pNum}, '_training_table.mat' );
    load(pFile);
    
   load('sac_endpoints.mat')

   [TTraining, time, xEnd, yEnd, cleanRatio(pNum)] = ssd_cleanData(TTraining, time, xEnd, yEnd, 21.5, 120);
    
    save('cleanData.mat', 'TTraining', 'xEnd', 'yEnd', 'time')
end

cd(expFolder)
save('cleanRatio.mat', 'cleanRatio')