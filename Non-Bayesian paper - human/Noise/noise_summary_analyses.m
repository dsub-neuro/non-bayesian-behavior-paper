expFolder = 'C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Noise experiment'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
names = {'JT', 'KR', 'MB', 'P2', 'P3', 'P4', 'P6', 'P7', 'P8'};
dates = {'18May2016', '16May2016', '19May2016', '14Sep2016', '16Sep2016', '03Nov2016', '07Nov2016', '06Jan2017', '13Jan2017'};

binSize = 0.25;

cloud.Criterion = NaN(9, 2); %lowNoiseCriterion, highNoiseCriterion,
cloud.DPrime = NaN(9, 2); %lowNoiseDPrime, highNoiseDPrime
cloud.lowNoiseBins = NaN(9, 16);
cloud.highNoiseBins = NaN(9, 16);

arrow.Criterion = NaN(9, 2);%lowNoiseCriterion, highNoiseCriterion
arrow.DPrime = NaN(9, 2);
arrow.lowNoiseBins = NaN(9, 16);
arrow.highNoiseBins = NaN(9, 16);

contrast.Criterion = NaN(9, 2); %lowNoiseCriterion, highNoiseCriterion
contrast.DPrime = NaN(9, 2);
contrast.lowNoiseBins = NaN(9, 16);
contrast.highNoiseBins = NaN(9, 16);

blob.Criterion = NaN(9, 2); %lowNoiseCriterion, highNoiseCriterion
blob.DPrime = NaN(9, 2);
blob.lowNoiseBins = NaN(9, 16);
blob.highNoiseBins = NaN(9, 16);

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
    
    [arrow.Criterion(pNum, 1), arrow.DPrime(pNum, 1)] = signalDetection(isJump(arrowType & lowNoise), resp(arrowType & lowNoise));
    [arrow.Criterion(pNum, 2), arrow.DPrime(pNum, 2)] = signalDetection(isJump(arrowType & highNoise), resp(arrowType & highNoise));
    
    [contrast.Criterion(pNum, 1), contrast.DPrime(pNum, 1)] = signalDetection(isJump(contrastType & lowNoise), resp(contrastType & lowNoise));
    [contrast.Criterion(pNum, 2), contrast.DPrime(pNum, 2)] = signalDetection(isJump(contrastType & highNoise), resp(contrastType & highNoise));
    
    [blob.Criterion(pNum, 1), blob.DPrime(pNum, 1)] = signalDetection(isJump(blobType & lowNoise), resp(blobType & lowNoise));
    [blob.Criterion(pNum, 2), blob.DPrime(pNum, 2)] = signalDetection(isJump(blobType & highNoise), resp(blobType & highNoise));
    
    [cloud.min(pNum), cloud.slope(pNum), cloud.threshold(pNum), cloud.max(pNum), cloud.curve(pNum, :), ~] = psychCurve_4P(X, Y, curveSpace)
    [cloud.lowNoise(pNum).coef, cloud.lowNoise(pNum).dev, cloud.lowNoise(pNum).stats, cloud.lowNoise(pNum).curves, cloud.lowNoise(pNum).thresh] = psychCurves(jumpSize(cloudType & lowNoise), resp(cloudType & lowNoise), 0.5, 4);
    [cloud.highNoise(pNum).coef, cloud.highNoise(pNum).dev, cloud.highNoise(pNum).stats, cloud.highNoise(pNum).curves, cloud.highNoise(pNum).thresh] = psychCurves(jumpSize(cloudType & highNoise), resp(cloudType & highNoise), 0.5, 4);
    cloud.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(cloudType & lowNoise), resp(cloudType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    cloud.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(cloudType & highNoise), resp(cloudType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants

    [arrow.lowNoise(pNum).coef, arrow.lowNoise(pNum).dev, arrow.lowNoise(pNum).stats, arrow.lowNoise(pNum).curves, arrow.lowNoise(pNum).thresh] = psychCurves(jumpSize(arrowType & lowNoise), resp(arrowType & lowNoise), 0.5, 4);
    [arrow.highNoise(pNum).coef, arrow.highNoise(pNum).dev, arrow.highNoise(pNum).stats, arrow.highNoise(pNum).curves, arrow.highNoise(pNum).thresh] = psychCurves(jumpSize(arrowType & highNoise), resp(arrowType & highNoise), 0.5, 4);
    arrow.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(arrowType & lowNoise), resp(arrowType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    arrow.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(arrowType & highNoise), resp(arrowType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    
    [contrast.lowNoise(pNum).coef, contrast.lowNoise(pNum).dev, contrast.lowNoise(pNum).stats, contrast.lowNoise(pNum).curves, contrast.lowNoise(pNum).thresh] = psychCurves(jumpSize(contrastType & lowNoise), resp(contrastType & lowNoise), 0.5, 4);
    [contrast.highNoise(pNum).coef, contrast.highNoise(pNum).dev, contrast.highNoise(pNum).stats, contrast.highNoise(pNum).curves, contrast.highNoise(pNum).thresh] = psychCurves(jumpSize(contrastType & highNoise), resp(contrastType & highNoise), 0.5, 4);
    contrast.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(contrastType & lowNoise), resp(contrastType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    contrast.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(contrastType & highNoise), resp(contrastType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    
    [blob.lowNoise(pNum).coef, blob.lowNoise(pNum).dev, blob.lowNoise(pNum).stats, blob.lowNoise(pNum).curves, blob.lowNoise(pNum).thresh] = psychCurves(jumpSize(blobType & lowNoise), resp(blobType & lowNoise), 0.5, 4);
    [blob.highNoise(pNum).coef, blob.highNoise(pNum).dev, blob.highNoise(pNum).stats, blob.highNoise(pNum).curves, blob.highNoise(pNum).thresh] = psychCurves(jumpSize(blobType & highNoise), resp(blobType & highNoise), 0.5, 4);
    blob.lowNoiseBins(pNum, :) = psychCurveBins(jumpSize(blobType & lowNoise), resp(blobType & lowNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants
    blob.highNoiseBins(pNum, :) = psychCurveBins(jumpSize(blobType & highNoise), resp(blobType & highNoise), binSize, 4); %creates matrix for baseline psychometric curves for all participants    
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

save('noise_summary_data.mat', 'cloud', 'arrow', 'contrast', 'blob')