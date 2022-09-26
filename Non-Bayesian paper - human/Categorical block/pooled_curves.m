validParticipants = [1, 3, 4, 6:8, 10:20];
n = length(validParticipants);

jmpspace = linspace(0, 4, 10000);

baselineTotal = [];
lowPriorNoNoiseTotal = [];
highPriorNoNoiseTotal = [];
lowPriorLowNoiseTotal = [];
highPriorLowNoiseTotal = [];
lowPriorHighNoiseTotal = [];
highPriorHighNoiseTotal = [];

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
    baselineResp = TTraining.Response(baseline)/5; %get responses as 0s and 1s
    
    baselineJSResp = [baselineJS, baselineResp];
    baselineTotal = [baselineTotal; baselineJSResp];
  
    lowPriorNoNoiseJS = abs(TTraining.JumpSize(lowPriorNoNoise)); %get absolute values of jump sizes
    lowPriorNoNoiseResp = TTraining.Response(lowPriorNoNoise)/5; %get responses as 0s and 1s

    lowPriorNoNoiseJSResp = [lowPriorNoNoiseJS, lowPriorNoNoiseResp];
    lowPriorNoNoiseTotal = [lowPriorNoNoiseTotal; lowPriorNoNoiseJSResp];
    
    highPriorNoNoiseJS = abs(TTraining.JumpSize(highPriorNoNoise)); %get absolute values of jump sizes
    highPriorNoNoiseResp = TTraining.Response(highPriorNoNoise)/5; %get responses as 0s and 1s

    highPriorNoNoiseJSResp = [highPriorNoNoiseJS, highPriorNoNoiseResp];
    highPriorNoNoiseTotal = [highPriorNoNoiseTotal; highPriorNoNoiseJSResp];
    
    lowPriorLowNoiseJS = abs(TTraining.JumpSize(lowPriorLowNoise)); %get absolute values of jump sizes
    lowPriorLowNoiseResp = TTraining.Response(lowPriorLowNoise)/5; %get responses as 0s and 1s

    lowPriorLowNoiseJSResp = [lowPriorLowNoiseJS, lowPriorLowNoiseResp];
    lowPriorLowNoiseTotal = [lowPriorLowNoiseTotal; lowPriorLowNoiseJSResp];
   
    highPriorLowNoiseJS = abs(TTraining.JumpSize(highPriorLowNoise)); %get absolute values of jump sizes
    highPriorLowNoiseResp = TTraining.Response(highPriorLowNoise)/5; %get responses as 0s and 1s
    
    highPriorLowNoiseJSResp = [highPriorLowNoiseJS, highPriorLowNoiseResp];
    highPriorLowNoiseTotal = [highPriorLowNoiseTotal; highPriorLowNoiseJSResp];
    
    lowPriorHighNoiseJS = abs(TTraining.JumpSize(lowPriorHighNoise)); %get absolute values of jump sizes
    lowPriorHighNoiseResp = TTraining.Response(lowPriorHighNoise)/5; %get responses as 0s and 1s
    
    lowPriorHighNoiseJSResp = [lowPriorHighNoiseJS, lowPriorHighNoiseResp];
    lowPriorHighNoiseTotal = [lowPriorHighNoiseTotal; lowPriorHighNoiseJSResp];
    
    highPriorHighNoiseJS = abs(TTraining.JumpSize(highPriorHighNoise)); %get absolute values of jump sizes
    highPriorHighNoiseResp = TTraining.Response(highPriorHighNoise)/5; %get responses as 0s and 1s
    
    highPriorHighNoiseJSResp = [highPriorHighNoiseJS, highPriorHighNoiseResp];
    highPriorHighNoiseTotal = [highPriorHighNoiseTotal; highPriorHighNoiseJSResp];
    
end

%% 
[min.baseline, slope.baseline, threshold.baseline, max.baseline, baselineCurve, ~] = psychCurve_4P(baselineTotal(:, 1), baselineTotal(:, 2), jmpspace);   
[min.lowPriorNoNoise, slope.lowPriorNoNoise, threshold.lowPriorNoNoise, max.lowPriorNoNoise, lowPriorNoNoiseCurve, ~] = psychCurve_4P(lowPriorNoNoiseTotal(:, 1), lowPriorNoNoiseTotal(:, 2), jmpspace);   
[min.highPriorNoNoise, slope.highPriorNoNoise, threshold.highPriorNoNoise, max.highPriorNoNoise, highPriorNoNoiseCurve, ~] = psychCurve_4P(highPriorNoNoiseTotal(:, 1), highPriorNoNoiseTotal(:, 2), jmpspace);   

[min.lowPriorLowNoise, slope.lowPriorLowNoise, threshold.lowPriorLowNoise, max.lowPriorLowNoise, lowPriorLowNoiseCurve, ~] = psychCurve_4P(lowPriorLowNoiseTotal(:, 1), lowPriorLowNoiseTotal(:, 2), jmpspace);   
[min.highPriorLowNoise, slope.highPriorLowNoise, threshold.highPriorLowNoise, max.highPriorLowNoise, highPriorLowNoiseCurve, ~] = psychCurve_4P(highPriorLowNoiseTotal(:, 1), highPriorLowNoiseTotal(:, 2), jmpspace);   

[min.lowPriorHighNoise, slope.lowPriorHighNoise, threshold.lowPriorHighNoise, max.lowPriorHighNoise, lowPriorHighNoiseCurve, ~] = psychCurve_4P(lowPriorHighNoiseTotal(:, 1), lowPriorHighNoiseTotal(:, 2), jmpspace);   
[min.highPriorHighNoise, slope.highPriorHighNoise, threshold.highPriorHighNoise, max.highPriorHighNoise, highPriorHighNoiseCurve, ~] = psychCurve_4P(highPriorHighNoiseTotal(:, 1), highPriorHighNoiseTotal(:, 2), jmpspace);   

%% 
save('summary_pooledCurves_4P_2.mat', 'baselineCurve', 'lowPriorNoNoiseCurve', 'highPriorNoNoiseCurve', 'lowPriorLowNoiseCurve', 'highPriorLowNoiseCurve', 'lowPriorHighNoiseCurve', 'highPriorHighNoiseCurve'); 