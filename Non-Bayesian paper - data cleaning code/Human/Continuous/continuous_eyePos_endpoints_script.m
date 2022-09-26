expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Continuous experiment'; %switch to Continuous Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
load('nameDate.mat')

for pNum = 1:14 %loop through participants
    pFolder = strcat(expFolder, '\', nameDate{1, pNum}, '_', nameDate{2, pNum}); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(nameDate{1, pNum}, '_testing_table.mat' );
    load(pFile);
    
   load('eyeData_testing.mat')

   [time, xEnd, yEnd] = eyepos_endpoints(timeTe, xPosTe, yPosTe, testing, 49.7);

   save('sac_endpoints.mat', 'xEnd', 'yEnd', 'time')
end