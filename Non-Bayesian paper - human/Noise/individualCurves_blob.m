%% get individual psychometric curves
expFolder = 'C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Noise experiment'; %switch to Noise Experiment folder
cd(expFolder)
%Participant names and dates to refer to data folders
names = {'JT', 'KR', 'MB', 'P2', 'P3', 'P4', 'P6', 'P7', 'P8'};
dates = {'18May2016', '16May2016', '19May2016', '14Sep2016', '16Sep2016', '03Nov2016', '07Nov2016', '06Jan2017', '13Jan2017'};

binSize = 0.25;
jmpspace = linspace(0, 4, 10000);

blob.lowNoiseCurvesInd = NaN(9, 10000);
blob.highNoiseCurvesInd = NaN(9, 10000);
blob.min = NaN(9, 2);
blob.slope = NaN(9, 2);
blob.threshold = NaN(9, 2);
blob.max = NaN(9, 2);

for pNum = 1:9 %loop through participants
    pFolder = strcat(expFolder, '\', names{pNum}, '_', dates{pNum}); %switch to participant folder
    cd(pFolder)
    
    load('cleanData.mat');
    
    blobType = noiseTable.NoiseType == 6;
    
    lowNoise = noiseTable.Noise == 16;
    highNoise = noiseTable.Noise == 4;
    
    resp = noiseTable.RSP/5;
    jumpSize = abs(noiseTable.JumpSize);
    isJump = noiseTable.isJump;

    [blob.min(pNum, 1), blob.slope(pNum, 1), blob.threshold(pNum, 1), blob.max(pNum, 1), blob.lowNoiseCurvesInd(pNum, :), ~] = psychCurve_4P(jumpSize(blobType & lowNoise), resp(blobType & lowNoise), jmpspace);   
    [blob.min(pNum, 2), blob.slope(pNum, 2), blob.threshold(pNum, 2), blob.max(pNum, 2), blob.highNoiseCurvesInd(pNum, :), ~] = psychCurve_4P(jumpSize(blobType & highNoise), resp(blobType & highNoise), jmpspace);   
end

blob1 = blob;
save('curvesAll_blob.mat', 'blob1')

%% plot individual psychometric curves
cd(expFolder)
load('noise_summary_4P.mat')
load('curvesAll_blob.mat')

%%
bins = 0.125:binSize:3.875;
jmpspace = linspace(0, 4, 10000);

for ii = 1:9
    currFig = figure;
    plot(bins, blob.lowNoiseBins(ii, :), 'ko', 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, blob1.lowNoiseCurvesInd(ii, :), 'color', 'k', 'LineWidth', 2)
    hold on
    plot(bins, blob.highNoiseBins(ii, :), 'ro', 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, blob1.highNoiseCurvesInd(ii, :), 'color', 'r', 'LineWidth', 2)
    box off
    set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
    yticks([0 0.25 0.5 0.75 1])
    xlim([0 3])
    title(num2str(ii))
    fileNameMat = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\MATLAB\Noise experiment\Individual curves\', num2str(ii), '.m');
    fileNameSVG = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\SVG\Noise experiment\Individual curves\', num2str(ii), '.svg');
    
    saveas(currFig, fileNameMat)
    saveas(currFig, fileNameSVG)
    
end

