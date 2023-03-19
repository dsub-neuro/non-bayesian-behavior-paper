validParticipants = [1, 3, 4, 6:8, 10:20];
n = length(validParticipants);

lb = [0, 0, 0, 0, 0, -5, -5, -5, 0, 0, 0, 0, 0, 0];
ub = [5, 5, 5, 2, 2, 5, 5, 5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];

initLB = [0.2, 0.2, 0.1, 2, 0, -1, -2, -3, 0, 0, 0, 0, 0, 0];
initUB = [0.8, 0.65, 0.4, 4, 1, 0, 0, 0, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3];

initConditions = NaN(10, 14); %number of runs X number of parameters

for ii = 1:10
    initConditions(ii, :) = unifrnd(initLB, initUB);
end

%% 
for participant = 3
    pNum = validParticipants(participant); 
    
    filename = strcat('C:\Users\subramaniand2\OneDrive - National Institutes of Health\Data\Sommer lab\Behavior paper\Categorical experiment - block\Valid data - Categorical\cleanData_', num2str(pNum), '.mat'); %get file name by converting current loop index to a string and concatenating it to the rest of the file name
    load(filename)
    
    valid = ~isnan(TTraining.Response) & ~(TTraining.Color == 3 & TTraining.Noise > 2); %exclude aborted trials and a small proportion of low- and high-noise trials that were presented in the baseline condition
    data = TTraining(valid, :); 
    
    fVal = NaN(10, 1);
    params = NaN(10, 14); 
    options = optimoptions('fmincon', 'MaxFunctionEvaluations', 15000);

    for inits = 1:10
       [params(inits, :), fVal(inits)] = fmincon(@(coef) bayesModel_human_withLapsesByNoise(data, coef), initConditions(inits, :), [], [], [], [], lb, ub, [], options);
    end

paramsFinal = array2table(paramsFinal, 'VariableNames', {'noNoise', 'lowNoise', 'highNoise', 'jumpDist', 'noJumpDist', 'lowPriorOdds', 'medPriorOdds', 'highPriorOdds', 'noNoiseLowerBound', 'noNoiseLapse', 'lowNoiseLowerBound', 'lowNoiseLapse', 'highNoiseLowerBound', 'highNoiseLapse'});

cd('C:\Users\subramaniand2\OneDrive - National Institutes of Health\Data\Sommer lab\Behavior paper\Categorical experiment - block\Valid data - Categorical\Model fits\Randomized init by participant')
saveName = strcat(num2str(pNum), '.mat');

save(saveName, 'params', 'fVal')

end