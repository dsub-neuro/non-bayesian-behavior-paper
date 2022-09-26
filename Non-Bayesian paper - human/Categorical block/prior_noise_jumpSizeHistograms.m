valid = ~isnan(TTraining.Response);
TTraining = TTraining(valid, :);

resp = TTraining.Response/5;

jumpResp = resp == 1;

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
%all priors, no noise
subplot(1, 3, 1)
histogram(abs(TTraining.JumpSize(baseline & jumpResp)), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(baseline & ~jumpResp)), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability')
box off
ylim([0 1])

subplot(1, 3, 2)
histogram(abs(TTraining.JumpSize(lowPriorNoNoise & jumpResp)), binEdges, 'FaceColor', 'b', 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(lowPriorNoNoise & ~jumpResp)), binEdges, 'FaceColor', 'c', 'Normalization', 'probability')
box off
ylim([0 1])

subplot(1, 3, 3)
histogram(abs(TTraining.JumpSize(highPriorNoNoise & jumpResp)), binEdges, 'FaceColor', 'r', 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(highPriorNoNoise & ~jumpResp)), binEdges, 'FaceColor', 'm', 'Normalization', 'probability')
box off
ylim([0 1])

%% low prior, all noise

subplot(1, 3, 1)
histogram(abs(TTraining.JumpSize(lowPriorNoNoise & jumpResp)), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(lowPriorNoNoise & ~jumpResp)), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability')
box off
ylim([0 1])

subplot(1, 3, 2)
histogram(abs(TTraining.JumpSize(lowPriorLowNoise & jumpResp)), binEdges, 'FaceColor', 'b', 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(lowPriorLowNoise & ~jumpResp)), binEdges, 'FaceColor', 'c', 'Normalization', 'probability')
box off
ylim([0 1])

subplot(1, 3, 3)
histogram(abs(TTraining.JumpSize(lowPriorHighNoise & jumpResp)), binEdges, 'FaceColor', 'r', 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(lowPriorHighNoise & ~jumpResp)), binEdges, 'FaceColor', 'm', 'Normalization', 'probability')
box off
ylim([0 1])

%% high prior, all noise
subplot(1, 3, 1)
histogram(abs(TTraining.JumpSize(highPriorNoNoise & jumpResp)), binEdges, 'FaceColor', [0.5 0.5 0.5], 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(highPriorNoNoise & ~jumpResp)), binEdges, 'FaceColor', [0.8 0.8 0.8], 'Normalization', 'probability')
box off
ylim([0 1])

subplot(1, 3, 2)
histogram(abs(TTraining.JumpSize(highPriorLowNoise & jumpResp)), binEdges, 'FaceColor', 'b', 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(highPriorLowNoise & ~jumpResp)), binEdges, 'FaceColor', 'c', 'Normalization', 'probability')
box off
ylim([0 1])

subplot(1, 3, 3)
histogram(abs(TTraining.JumpSize(highPriorHighNoise & jumpResp)), binEdges, 'FaceColor', 'r', 'Normalization', 'probability')
hold on
histogram(abs(TTraining.JumpSize(highPriorHighNoise & ~jumpResp)), binEdges, 'FaceColor', 'm', 'Normalization', 'probability')
box off
ylim([0 1])

