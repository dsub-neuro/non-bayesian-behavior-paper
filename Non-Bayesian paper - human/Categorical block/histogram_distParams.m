baselineParams = NaN(20, 4); %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]
lowPriorNoNoiseParams = NaN(20, 4); %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]
highPriorNoNoiseParams = NaN(20, 4); %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

lowPriorLowNoiseParams = NaN(20, 4); %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]
highPriorLowNoiseParams = NaN(20, 4); %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

lowPriorHighNoiseParams = NaN(20, 4); %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]
highPriorHighNoiseParams = NaN(20, 4); %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

%% get data from all participants
for participant = 1:20
    filename = strcat('cleanData_', num2str(participant), '.mat'); %get file name by converting current loop index to a string and concatenating it to the rest of the file name
    load(filename)
  %%  
    valid = ~isnan(TTraining.Response);
    TTraining = TTraining(valid, :);
    
    resp = TTraining.Response/5;
    jumpResp = resp == 1;
    
    jumpSize = abs(TTraining.JumpSize);
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
    
    binEdges = 0:0.1:4;
    %% plots
    %baseline
    baselineJump = histogram(jumpSize(baseline & jumpResp), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability');
    pd = fitdist(baselineJump.Values', 'Normal');
    baselineParams(participant, 1:2) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    baselineNoJump = histogram(jumpSize(baseline & ~jumpResp), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability');
    pd = fitdist(baselineNoJump.Values', 'Normal');
    baselineParams(participant, 3:4) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    %lowPriorNoNoise
    lowPriorNoNoiseJump = histogram(jumpSize(lowPriorNoNoise & jumpResp), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability');
    pd = fitdist(lowPriorNoNoiseJump.Values', 'Normal');
    lowPriorNoNoiseParams(participant, 1:2) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    lowPriorNoNoiseNoJump = histogram(jumpSize(lowPriorNoNoise & ~jumpResp), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability');
    pd = fitdist(lowPriorNoNoiseNoJump.Values', 'Normal');
    lowPriorNoNoiseParams(participant, 3:4) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]
 
    %lowPriorLowNoise
    lowPriorLowNoiseJump = histogram(jumpSize(lowPriorLowNoise & jumpResp), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability');
    pd = fitdist(lowPriorLowNoiseJump.Values', 'Normal');
    lowPriorLowNoiseParams(participant, 1:2) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    lowPriorLowNoiseNoJump = histogram(jumpSize(lowPriorLowNoise & ~jumpResp), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability');
    pd = fitdist(lowPriorLowNoiseNoJump.Values', 'Normal');
    lowPriorLowNoiseParams(participant, 3:4) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    %lowPriorHighNoise
    lowPriorHighNoiseJump = histogram(jumpSize(lowPriorHighNoise & jumpResp), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability');
    pd = fitdist(lowPriorHighNoiseJump.Values', 'Normal');
    lowPriorHighNoiseParams(participant, 1:2) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    lowPriorHighNoiseNoJump = histogram(jumpSize(lowPriorHighNoise & ~jumpResp), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability');
    pd = fitdist(lowPriorHighNoiseNoJump.Values', 'Normal');
    lowPriorHighNoiseParams(participant, 3:4) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    %highPriorNoNoise
    highPriorNoNoiseJump = histogram(jumpSize(highPriorNoNoise & jumpResp), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability');
    pd = fitdist(highPriorNoNoiseJump.Values', 'Normal');
    highPriorNoNoiseParams(participant, 1:2) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    highPriorNoNoiseNoJump = histogram(jumpSize(highPriorNoNoise & ~jumpResp), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability');
    pd = fitdist(highPriorNoNoiseNoJump.Values', 'Normal');
    highPriorNoNoiseParams(participant, 3:4) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    %highPriorLowNoise
    highPriorLowNoiseJump = histogram(jumpSize(highPriorLowNoise & jumpResp), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability');
    pd = fitdist(highPriorLowNoiseJump.Values', 'Normal');
    highPriorLowNoiseParams(participant, 1:2) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    highPriorLowNoiseNoJump = histogram(jumpSize(highPriorLowNoise & ~jumpResp), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability');
    pd = fitdist(highPriorLowNoiseNoJump.Values', 'Normal');
    highPriorLowNoiseParams(participant, 3:4) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    %highPriorHighNoise
    highPriorHighNoiseJump = histogram(jumpSize(highPriorHighNoise & jumpResp), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability');
    pd = fitdist(highPriorHighNoiseJump.Values', 'Normal');
    highPriorHighNoiseParams(participant, 1:2) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    highPriorHighNoiseNoJump = histogram(jumpSize(highPriorHighNoise & ~jumpResp), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability');
    pd = fitdist(highPriorHighNoiseNoJump.Values', 'Normal');
    highPriorHighNoiseParams(participant, 3:4) = [pd.mu pd.sigma]; %[jumpMean, jumpSTD, noJumpMean, noJumpSTD]

    
end

names = {'jumpMean', 'jumpSTD', 'noJumpMean', 'noJumpSTD'};
baselineParams = array2table(baselineParams);
baselineParams.Properties.VariableNames = names;

lowPriorNoNoiseParams = array2table(lowPriorNoNoiseParams);
lowPriorNoNoiseParams.Properties.VariableNames = names;

highPriorNoNoiseParams = array2table(highPriorNoNoiseParams);
highPriorNoNoiseParams.Properties.VariableNames = names;

lowPriorLowNoiseParams = array2table(lowPriorLowNoiseParams);
lowPriorLowNoiseParams.Properties.VariableNames = names;

highPriorLowNoiseParams = array2table(highPriorLowNoiseParams);
highPriorLowNoiseParams.Properties.VariableNames = names;

lowPriorHighNoiseParams = array2table(lowPriorHighNoiseParams);
lowPriorHighNoiseParams.Properties.VariableNames = names;

highPriorHighNoiseParams = array2table(highPriorHighNoiseParams);
highPriorHighNoiseParams.Properties.VariableNames = names;
