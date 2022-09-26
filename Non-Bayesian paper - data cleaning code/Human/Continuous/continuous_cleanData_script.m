expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Continuous experiment'; %switch to Continuous Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
load('nameDate.mat')

cleanRatio = NaN(14, 1);
for pNum = 1:14 %loop through participants
    pFolder = strcat(expFolder, '\', nameDate{1, pNum}, '_', nameDate{2, pNum}); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(nameDate{1, pNum}, '_testing_table.mat' );
    load(pFile);
    
   load('sac_endpoints.mat')

   [testing, time, xEnd, yEnd, cleanRatio(pNum)] = ssd_cleanData(testing, time, xEnd, yEnd, 49.7, 60);
    
    save('cleanData.mat', 'testing', 'xEnd', 'yEnd', 'time')
end

cd(expFolder)
save('cleanRatio.mat', 'cleanRatio')