expFolder = 'C:\Users\Divya\Box Sync\Sommer_Psychophysics\Divya\Data\Non-Bayesian paper data - human\Noise experiment'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
names = {'JT', 'KR', 'MB', 'P2', 'P3', 'P4', 'P6', 'P7', 'P8'};
dates = {'18May2016', '16May2016', '19May2016', '14Sep2016', '16Sep2016', '03Nov2016', '07Nov2016', '06Jan2017', '13Jan2017'};


for pNum = 1:9 %loop through participants
    pFolder = strcat(expFolder, '\', names{pNum}, '_', dates{pNum}); %switch to participant folder
    cd(pFolder)
    
    pFile = strcat(names{pNum}, '_noiseTable.mat' );
    load(pFile); 

    load('eyeData_noise.mat')
    
    [time, xEnd, yEnd] = eyepos_endpoints(timeNoise, xPosNoise, yPosNoise, noiseTable, 21.5);
    
    save('sac_endpoints.mat', 'xEnd', 'yEnd', 'time')
end