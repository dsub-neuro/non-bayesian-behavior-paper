expFolder = 'C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Noise experiment'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
names = {'JT', 'KR', 'MB', 'P2', 'P3', 'P4', 'P6', 'P7', 'P8'};
dates = {'18May2016', '16May2016', '19May2016', '14Sep2016', '16Sep2016', '03Nov2016', '07Nov2016', '06Jan2017', '13Jan2017'};

binSize = 0.25;
jmpspace = linspace(0, 4, 10000);

cloud.Criterion = NaN(9, 2); %lowNoiseCriterion, highNoiseCriterion,
cloud.DPrime = NaN(9, 2); %lowNoiseDPrime, highNoiseDPrime
cloud.lowNoiseBins = NaN(9, 16);
cloud.highNoiseBins = NaN(9, 16);
cloudLowNoiseTotal = [];
cloudHighNoiseTotal = [];
cloud.lowNoiseCurve = NaN(1, 10000);
cloud.highNoiseCurve = NaN(1, 10000); 

arrow.Criterion = NaN(9, 2);%lowNoiseCriterion, highNoiseCriterion
arrow.DPrime = NaN(9, 2);
arrow.lowNoiseBins = NaN(9, 16);
arrow.highNoiseBins = NaN(9, 16);
arrowLowNoiseTotal = [];
arrowHighNoiseTotal = [];
arrow.lowNoiseCurve = NaN(1, 10000);
arrow.highNoiseCurve = NaN(1, 10000); 

contrast.Criterion = NaN(9, 2); %lowNoiseCriterion, highNoiseCriterion
contrast.DPrime = NaN(9, 2);
contrast.lowNoiseBins = NaN(9, 16);
contrast.highNoiseBins = NaN(9, 16);
contrastLowNoiseTotal = [];
contrastHighNoiseTotal = [];
contrast.lowNoiseCurve = NaN(1, 10000);
contrast.highNoiseCurve = NaN(1, 10000); 


blob.Criterion = NaN(9, 2); %lowNoiseCriterion, highNoiseCriterion
blob.DPrime = NaN(9, 2);
blob.lowNoiseBins = NaN(9, 16);
blob.highNoiseBins = NaN(9, 16);
blobLowNoiseTotal = [];
blobHighNoiseTotal = [];
blob.lowNoiseCurve = NaN(1, 10000);
blob.highNoiseCurve = NaN(1, 10000);

for pNum = 1:9 %loop through participants
    pFolder = strcat(expFolder, '\', names{pNum}, '_', dates{pNum}); %switch to participant folder
    cd(pFolder)
    
    load('cleanData.mat');
    
    cloudType = noiseTable.NoiseType == 1;
    arrowType = noiseTable.NoiseType == 3;
    contrastType = noiseTable.NoiseType == 5;
    blobType = noiseTable.NoiseType == 6;
    
    lowNoise = noiseTable.Noise == 16;
    highNoise = noiseTable.Noise == 4;
    
    resp = noiseTable.RSP/5;
    jumpSize = abs(noiseTable.JumpSize);
    isJump = noiseTable.isJump;

    [cloud.Criterion(pNum, 1), cloud.DPrime(pNum, 1)] = signalDetection(isJump(cloudType & lowNoise), resp(cloudType & lowNoise));
    [cloud.Criterion(pNum, 2), cloud.DPrime(pNum, 2)] = signalDetection(isJump(cloudType & highNoise), resp(cloudType & highNoise));
    cloud.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(cloudType & lowNoise), resp(cloudType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    cloud.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(cloudType & highNoise), resp(cloudType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    cloudLowNoiseJSResp = [jumpSize(cloudType & lowNoise), resp(cloudType & lowNoise)];
    cloudLowNoiseTotal = [cloudLowNoiseTotal; cloudLowNoiseJSResp];
    cloudHighNoiseJSResp = [jumpSize(cloudType & highNoise), resp(cloudType & highNoise)];
    cloudHighNoiseTotal = [cloudHighNoiseTotal; cloudHighNoiseJSResp];
    [~, ~, ~, ~, cloud.lowNoiseCurve, ~] = psychCurve_4P(cloudLowNoiseTotal(:, 1), cloudLowNoiseTotal(:, 2), jmpspace);   
    [~, ~, ~, ~, cloud.highNoiseCurve, ~] = psychCurve_4P(cloudHighNoiseTotal(:, 1), cloudHighNoiseTotal(:, 2), jmpspace);   


    [arrow.Criterion(pNum, 1), arrow.DPrime(pNum, 1)] = signalDetection(isJump(arrowType & lowNoise), resp(arrowType & lowNoise));
    [arrow.Criterion(pNum, 2), arrow.DPrime(pNum, 2)] = signalDetection(isJump(arrowType & highNoise), resp(arrowType & highNoise));
    arrow.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(arrowType & lowNoise), resp(arrowType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    arrow.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(arrowType & highNoise), resp(arrowType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    arrowLowNoiseJSResp = [jumpSize(arrowType & lowNoise), resp(arrowType & lowNoise)];
    arrowLowNoiseTotal = [arrowLowNoiseTotal; arrowLowNoiseJSResp];
    arrowHighNoiseJSResp = [jumpSize(arrowType & highNoise), resp(arrowType & highNoise)];
    arrowHighNoiseTotal = [arrowHighNoiseTotal; arrowHighNoiseJSResp];
    [~, ~, ~, ~, arrow.lowNoiseCurve, ~] = psychCurve_4P(arrowLowNoiseTotal(:, 1), arrowLowNoiseTotal(:, 2), jmpspace);   
    [~, ~, ~, ~, arrow.highNoiseCurve, ~] = psychCurve_4P(arrowHighNoiseTotal(:, 1), arrowHighNoiseTotal(:, 2), jmpspace);   
 
    [contrast.Criterion(pNum, 1), contrast.DPrime(pNum, 1)] = signalDetection(isJump(contrastType & lowNoise), resp(contrastType & lowNoise));
    [contrast.Criterion(pNum, 2), contrast.DPrime(pNum, 2)] = signalDetection(isJump(contrastType & highNoise), resp(contrastType & highNoise));
    contrast.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(contrastType & lowNoise), resp(contrastType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    contrast.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(contrastType & highNoise), resp(contrastType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    contrastLowNoiseJSResp = [jumpSize(contrastType & lowNoise), resp(contrastType & lowNoise)];
    contrastLowNoiseTotal = [contrastLowNoiseTotal; contrastLowNoiseJSResp];
    contrastHighNoiseJSResp = [jumpSize(contrastType & highNoise), resp(contrastType & highNoise)];
    contrastHighNoiseTotal = [contrastHighNoiseTotal; contrastHighNoiseJSResp];
    [~, ~, ~, ~, contrast.lowNoiseCurve, ~] = psychCurve_4P(contrastLowNoiseTotal(:, 1), contrastLowNoiseTotal(:, 2), jmpspace);   
    [~, ~, ~, ~, contrast.highNoiseCurve, ~] = psychCurve_4P(contrastHighNoiseTotal(:, 1), contrastHighNoiseTotal(:, 2), jmpspace);   
      
    [blob.Criterion(pNum, 1), blob.DPrime(pNum, 1)] = signalDetection(isJump(blobType & lowNoise), resp(blobType & lowNoise));
    [blob.Criterion(pNum, 2), blob.DPrime(pNum, 2)] = signalDetection(isJump(blobType & highNoise), resp(blobType & highNoise));
    blob.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(blobType & lowNoise), resp(blobType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    blob.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(blobType & highNoise), resp(blobType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants    
    blobLowNoiseJSResp = [jumpSize(blobType & lowNoise), resp(blobType & lowNoise)];
    blobLowNoiseTotal = [blobLowNoiseTotal; blobLowNoiseJSResp];
    blobHighNoiseJSResp = [jumpSize(blobType & highNoise), resp(blobType & highNoise)];
    blobHighNoiseTotal = [blobHighNoiseTotal; blobHighNoiseJSResp];
    [~, ~, ~, ~, blob.lowNoiseCurve, ~] = psychCurve_4P(blobLowNoiseTotal(:, 1), blobLowNoiseTotal(:, 2), jmpspace);   
    [~, ~, ~, ~, blob.highNoiseCurve, ~] = psychCurve_4P(blobHighNoiseTotal(:, 1), blobHighNoiseTotal(:, 2), jmpspace);   

end

cloud.Criterion = array2table(cloud.Criterion, 'VariableNames', {'lowNoise', 'highNoise'}); %lowNoiseCriterion, highNoiseCriterion,
cloud.DPrime = array2table(cloud.DPrime, 'VariableNames', {'lowNoise', 'highNoise'}); %lowNoiseDPrime, highNoiseDPrime

arrow.Criterion = array2table(arrow.Criterion, 'VariableNames', {'lowNoise', 'highNoise'});%lowNoiseCriterion, highNoiseCriterion
arrow.DPrime = array2table(arrow.DPrime, 'VariableNames', {'lowNoise', 'highNoise'});

contrast.Criterion = array2table(contrast.Criterion, 'VariableNames', {'lowNoise', 'highNoise'}); %lowNoiseCriterion, highNoiseCriterion
contrast.DPrime = array2table(contrast.DPrime, 'VariableNames', {'lowNoise', 'highNoise'});

blob.Criterion = array2table(blob.Criterion, 'VariableNames', {'lowNoise', 'highNoise'}); %lowNoiseCriterion, highNoiseCriterion
blob.DPrime = array2table(blob.DPrime, 'VariableNames', {'lowNoise', 'highNoise'});

cd(expFolder)

save('noise_summary_4P.mat', 'binSize', 'cloud', 'arrow', 'contrast', 'blob')