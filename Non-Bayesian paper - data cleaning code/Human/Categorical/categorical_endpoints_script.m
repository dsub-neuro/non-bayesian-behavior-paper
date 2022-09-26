expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Categorical experiment - block'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
load('nameDate.mat')

for pNum = 1:20 %loop through participants
    pFolder = strcat(expFolder, '\', nameDate{1, pNum}, '_', nameDate{2, pNum}, '\Training'); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(nameDate{1, pNum}, '_training_table.mat' );
    load(pFile);
    
   load('eyeData_training.mat')

   [time, xEnd, yEnd] = eyepos_endpoints(timeTr, xPosTr, yPosTr, TTraining, 21.5);

   save('sac_endpoints.mat', 'xEnd', 'yEnd', 'time')
end