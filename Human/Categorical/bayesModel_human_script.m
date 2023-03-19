%% with lapses by noise condition

validParticipants = [1, 3, 4, 6:8, 10:20];
n = length(validParticipants);

params = NaN(17, 10);
fVal = NaN(17, 1);

for participant = 1:17
    pNum = validParticipants(participant); 
    
    filename = strcat('cleanData_', num2str(pNum), '.mat'); %get file name by converting current loop index to a string and concatenating it to the rest of the file name
    loadData = load(filename);
    
    TTraining = loadData.TTraining;
    valid = ~isnan(TTraining.Response) & ~(TTraining.Color == 3 & TTraining.Noise > 2); %exclude aborted trials and a small proportion of low- and high-noise trials that were presented in the baseline condition
    data = TTraining(valid, :); 
    options = optimoptions('fmincon', 'MaxFunctionEvaluations', 15000);

%     lb = [0, 0, 0, 2, 0, -5, -5, -5, 0, 0, 0, 0, 0, 0];
%     ub = [3, 3, 3, 5, 1.5, 5, 5, 5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
% 
%     init = [0.4, 0.4, 0.1, 2.5, 0.1, -0.3, -0.5, -2.5, 0.001, 0.01, 0.001, 0.1, 0.001, 0.2];
    
    lb = [0, 0, 0, 2, 0, -5, -5, -5, 0, 0];
    ub = [3, 3, 3, 5, 1.5, 5, 5, 5, 0.5, 0.5];
    
    init = [0.4, 0.4, 0.1, 2.5, 0.5, -0.3, -0.5, -2.5, 0.001, 0.01];


    [params(participant, :), fVal(participant)] = fmincon(@(coef) bayesModel_human_withLapsesByNoise(data, coef), init, [], [], [], [], lb, ub, [], options);

end
params = array2table(params, 'VariableNames', {'noNoise', 'lowNoise', 'highNoise', 'jumpDist', 'noJumpDist', 'lowPriorOdds', 'medPriorOdds', 'highPriorOdds', 'noNoiseLowerBound', 'noNoiseLapse', 'lowNoiseLowerBound', 'lowNoiseLapse', 'highNoiseLowerBound', 'highNoiseLapse'});


