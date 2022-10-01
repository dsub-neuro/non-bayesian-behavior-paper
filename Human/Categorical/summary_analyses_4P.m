%% generates data by experimental condition in the categorical experiment

cd('C:\Users\Divya\Documents\Divya data\Non Bayesian behavior paper data\Human\Categorical')

validParticipants = [1, 3, 4, 6:8, 10:20];
n = length(validParticipants);

binSize = 0.25;

baselinePsychCurves = NaN(n, 10000); %creates matrix for baseline psychometric curves for all participants
lowPriorNoNoisePsychCurves = NaN(n, 10000);
highPriorNoNoisePsychCurves = NaN(n, 10000);

lowPriorLowNoisePsychCurves = NaN(n, 10000);
highPriorLowNoisePsychCurves = NaN(n, 10000);

lowPriorHighNoisePsychCurves = NaN(n, 10000);
highPriorHighNoisePsychCurves = NaN(n, 10000);

baselinePsychBins = NaN(n, 4/binSize); %creates matrix for baseline psychometric curves for all participants
lowPriorNoNoisePsychBins = NaN(n, 4/binSize);
highPriorNoNoisePsychBins = NaN(n, 4/binSize);

lowPriorLowNoisePsychBins = NaN(n, 4/binSize);
highPriorLowNoisePsychBins = NaN(n, 4/binSize);

lowPriorHighNoisePsychBins = NaN(n, 4/binSize);
highPriorHighNoisePsychBins = NaN(n, 4/binSize);

min = NaN(n, 7); %participant x condition
slope = NaN(n, 7); %participant x condition
threshold = NaN(n, 7); %participant x condition
max = NaN(n, 7); %participant x condition

CriterionVals = NaN(n, 7); %participant x condition
dPrimeVals = NaN(n, 7); %participant x condition

jmpspace = linspace(0, 4, 10000);

%% get data from all participants
for participant = 1:n
    pNum = validParticipants(participant); 
    
    filename = strcat('cleanData_', num2str(pNum), '.mat'); %get file name by converting current loop index to a string and concatenating it to the rest of the file name
    load(filename)
    
    valid = ~isnan(TTraining.Response);
    TTraining = TTraining(valid, :); 
    
    baseline = TTraining.Color == 3 & TTraining.Noise == 2; %get baseline condition using logical indexing
    
    trls90 = TTraining.JProb  == 0.9;
    clr90 = unique(TTraining.Color(trls90));
    
    trls10 = TTraining.JProb == 0.1;
    clr10 = unique(TTraining.Color(trls10));
        
    lowPriorNoNoise = TTraining.Color == clr10 & TTraining.Noise == 2; 
    highPriorNoNoise = TTraining.Color == clr90 & TTraining.Noise == 2; 
    
    lowPriorLowNoise = TTraining.Color == clr10 & TTraining.Noise == 5; 
    highPriorLowNoise = TTraining.Color == clr90 & TTraining.Noise == 5; 
    
    lowPriorHighNoise = TTraining.Color == clr10 & TTraining.Noise == 10; 
    highPriorHighNoise = TTraining.Color == clr90 & TTraining.Noise == 10; 

    baselineJS = abs(TTraining.JumpSize(baseline)); %get absolute values of jump sizes
    baselineIsJump = TTraining.isJump(baseline);
    baselineResp = TTraining.Response(baseline)/5; %get responses as 0s and 1s
    baselineSize = length(baselineJS);
    
    lowPriorNoNoiseJS = abs(TTraining.JumpSize(lowPriorNoNoise)); %get absolute values of jump sizes
    lowPriorNoNoiseIsJump = TTraining.isJump(lowPriorNoNoise);
    lowPriorNoNoiseResp = TTraining.Response(lowPriorNoNoise)/5; %get responses as 0s and 1s
    lowPriorNoNoiseSize = length(lowPriorNoNoiseJS);

    highPriorNoNoiseJS = abs(TTraining.JumpSize(highPriorNoNoise)); %get absolute values of jump sizes
    highPriorNoNoiseIsJump = TTraining.isJump(highPriorNoNoise);
    highPriorNoNoiseResp = TTraining.Response(highPriorNoNoise)/5; %get responses as 0s and 1s
    highPriorNoNoiseSize = length(highPriorNoNoiseJS);

    lowPriorLowNoiseJS = abs(TTraining.JumpSize(lowPriorLowNoise)); %get absolute values of jump sizes
    lowPriorLowNoiseIsJump = TTraining.isJump(lowPriorLowNoise);    
    lowPriorLowNoiseResp = TTraining.Response(lowPriorLowNoise)/5; %get responses as 0s and 1s
    lowPriorLowNoiseSize = length(lowPriorLowNoiseJS);

    highPriorLowNoiseJS = abs(TTraining.JumpSize(highPriorLowNoise)); %get absolute values of jump sizes
    highPriorLowNoiseIsJump = TTraining.isJump(highPriorLowNoise);    
    highPriorLowNoiseResp = TTraining.Response(highPriorLowNoise)/5; %get responses as 0s and 1s
    highPriorLowNoiseSize = length(highPriorLowNoiseJS);
    
    lowPriorHighNoiseJS = abs(TTraining.JumpSize(lowPriorHighNoise)); %get absolute values of jump sizes
    lowPriorHighNoiseIsJump = TTraining.isJump(lowPriorHighNoise);        
    lowPriorHighNoiseResp = TTraining.Response(lowPriorHighNoise)/5; %get responses as 0s and 1s
    lowPriorHighNoiseSize = length(lowPriorHighNoiseJS);
    
    highPriorHighNoiseJS = abs(TTraining.JumpSize(highPriorHighNoise)); %get absolute values of jump sizes
    highPriorHighNoiseIsJump = TTraining.isJump(highPriorHighNoise);            
    highPriorHighNoiseResp = TTraining.Response(highPriorHighNoise)/5; %get responses as 0s and 1s
    highPriorHighNoiseSize = length(highPriorHighNoiseJS);
      
    %baseline
    baselineRange = 1 : baselineSize; %for all trials
    [min(participant, 1), slope(participant, 1), threshold(participant, 1), max(participant, 1), baselinePsychCurves(participant, :), ~] = psychCurve_4P(baselineJS(baselineRange), baselineResp(baselineRange), jmpspace);
    [CriterionVals(participant, 1), dPrimeVals(participant, 1)] = signalDetection(baselineIsJump(baselineRange), baselineResp(baselineRange));
    baselinePsychBins(participant, :) = psychCurveBins(baselineJS(baselineRange), baselineResp(baselineRange), binSize, 4); %creates matrix for baseline psychometric curves for all participants

    %lowPriorNoNoise
    lowPriorNoNoiseRange = 1 : lowPriorNoNoiseSize; %for all trials
    [min(participant, 2), slope(participant, 2), threshold(participant, 2), max(participant, 2), lowPriorNoNoisePsychCurves(participant, :), ~] = psychCurve_4P(lowPriorNoNoiseJS(lowPriorNoNoiseRange), lowPriorNoNoiseResp(lowPriorNoNoiseRange), jmpspace);   
    [CriterionVals(participant, 2), dPrimeVals(participant, 2)] = signalDetection(lowPriorNoNoiseIsJump(lowPriorNoNoiseRange), lowPriorNoNoiseResp(lowPriorNoNoiseRange));
    lowPriorNoNoisePsychBins(participant, :) = psychCurveBins(lowPriorNoNoiseJS(lowPriorNoNoiseRange), lowPriorNoNoiseResp(lowPriorNoNoiseRange), binSize, 4);
    
    %highPriorNoNoise
    highPriorNoNoiseRange = 1 : highPriorNoNoiseSize; %for all trials
    [min(participant, 3), slope(participant, 3), threshold(participant, 3), max(participant, 3), highPriorNoNoisePsychCurves(participant, :), ~] = psychCurve_4P(highPriorNoNoiseJS(highPriorNoNoiseRange), highPriorNoNoiseResp(highPriorNoNoiseRange), jmpspace);       
    [CriterionVals(participant, 3), dPrimeVals(participant, 3)] = signalDetection(highPriorNoNoiseIsJump(highPriorNoNoiseRange), highPriorNoNoiseResp(highPriorNoNoiseRange));
    highPriorNoNoisePsychBins(participant, :) = psychCurveBins(highPriorNoNoiseJS(highPriorNoNoiseRange), highPriorNoNoiseResp(highPriorNoNoiseRange), binSize, 4);

    %lowPriorLowNoise
    lowPriorLowNoiseRange = 1 : lowPriorLowNoiseSize; %for all trials
    [min(participant, 4), slope(participant, 4), threshold(participant, 4), max(participant, 4), lowPriorLowNoisePsychCurves(participant, :), ~] = psychCurve_4P(lowPriorLowNoiseJS(lowPriorLowNoiseRange), lowPriorLowNoiseResp(lowPriorLowNoiseRange), jmpspace);   
    [CriterionVals(participant, 4), dPrimeVals(participant, 4)] = signalDetection(lowPriorLowNoiseIsJump(lowPriorLowNoiseRange), lowPriorLowNoiseResp(lowPriorLowNoiseRange));
    lowPriorLowNoisePsychBins(participant, :) = psychCurveBins(lowPriorLowNoiseJS(lowPriorLowNoiseRange), lowPriorLowNoiseResp(lowPriorLowNoiseRange), binSize, 4);

    %highPriorLowNoise
    highPriorLowNoiseRange = 1 : highPriorLowNoiseSize; %for all trials
    [min(participant, 5), slope(participant, 5), threshold(participant, 5), max(participant, 5), highPriorLowNoisePsychCurves(participant, :), ~] = psychCurve_4P(highPriorLowNoiseJS(highPriorLowNoiseRange), highPriorLowNoiseResp(highPriorLowNoiseRange), jmpspace);   
    [CriterionVals(participant, 5), dPrimeVals(participant, 5)] = signalDetection(highPriorLowNoiseIsJump(highPriorLowNoiseRange), highPriorLowNoiseResp(highPriorLowNoiseRange));
    highPriorLowNoisePsychBins(participant, :) = psychCurveBins(highPriorLowNoiseJS(highPriorLowNoiseRange), highPriorLowNoiseResp(highPriorLowNoiseRange), binSize, 4);

    %lowPriorHighNoise
    lowPriorHighNoiseRange = 1 : lowPriorHighNoiseSize; %for all trials
    [min(participant, 6), slope(participant, 6), threshold(participant, 6), max(participant, 6), lowPriorHighNoisePsychCurves(participant, :), ~] = psychCurve_4P(lowPriorHighNoiseJS(lowPriorHighNoiseRange), lowPriorHighNoiseResp(lowPriorHighNoiseRange), jmpspace);   
    [CriterionVals(participant, 6), dPrimeVals(participant, 6)] = signalDetection(lowPriorHighNoiseIsJump(lowPriorHighNoiseRange), lowPriorHighNoiseResp(lowPriorHighNoiseRange));
    lowPriorHighNoisePsychBins(participant, :) = psychCurveBins(lowPriorHighNoiseJS(lowPriorHighNoiseRange), lowPriorHighNoiseResp(lowPriorHighNoiseRange), binSize, 4);

    %highPriorHighNoise
    highPriorHighNoiseRange = 1 : highPriorHighNoiseSize; %for all trials
    [min(participant, 7), slope(participant, 7), threshold(participant, 7), max(participant, 7), highPriorHighNoisePsychCurves(participant, :), ~] = psychCurve_4P(highPriorHighNoiseJS(highPriorHighNoiseRange), highPriorHighNoiseResp(highPriorHighNoiseRange), jmpspace);     
    [CriterionVals(participant, 7), dPrimeVals(participant, 7)] = signalDetection(highPriorHighNoiseIsJump(highPriorHighNoiseRange), highPriorHighNoiseResp(highPriorHighNoiseRange));
    highPriorHighNoisePsychBins(participant, :) = psychCurveBins(highPriorHighNoiseJS(highPriorHighNoiseRange), highPriorHighNoiseResp(highPriorHighNoiseRange), binSize, 4);
      
end

%% 
names = {'baseline', 'lowPriorNoNoise', 'highPriorNoNoise', 'lowPriorLowNoise', 'highPriorLowNoise', 'lowPriorHighNoise', 'highPriorHighNoise'};
min = array2table(min);
min.Properties.VariableNames = names;

slope = array2table(slope);
slope.Properties.VariableNames = names;

threshold = array2table(threshold);
threshold.Properties.VariableNames = names;

max = array2table(max);
max.Properties.VariableNames = names;

CriterionVals = array2table(CriterionVals);
CriterionVals.Properties.VariableNames = names;

dPrimeVals = array2table(dPrimeVals);
dPrimeVals.Properties.VariableNames = names;

save('summary_allTrials_4P_2.mat', 'baselinePsychCurves', 'lowPriorNoNoisePsychCurves', 'highPriorNoNoisePsychCurves', 'lowPriorLowNoisePsychCurves', 'highPriorLowNoisePsychCurves', 'lowPriorHighNoisePsychCurves', 'highPriorHighNoisePsychCurves', 'baselinePsychBins', 'lowPriorNoNoisePsychBins', 'highPriorNoNoisePsychBins', 'lowPriorLowNoisePsychBins', 'highPriorLowNoisePsychBins', 'lowPriorHighNoisePsychBins', 'highPriorHighNoisePsychBins', 'min', 'slope', 'threshold', 'max', 'CriterionVals', 'dPrimeVals', 'binSize');
