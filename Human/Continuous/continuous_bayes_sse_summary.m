%% fits continuous Bayesian model to data and gets model parameters
%calls continuous_bayes_sse
%% param set-up file for all SD fits
params = NaN(11, 5);
fVal = NaN(11, 1);

validParticipants = [1:2, 4, 6, 8:14];

init = [0.1, 0.3, 0.7, 0.0001, 1];
lb = [0, 0, 0, 0, 0];
ub = [10, 10, 10, 10, 10]; 

% %% params set-up for only prior fits
% paramsOnlyPrior = NaN(11, 2);
% fValOnlyPrior = NaN(11, 1);
% 
% initOnlyPrior = [0.0001, 1];
% lbOnlyPrior = [0, 0];
% ubOnlyPrior = [10, 10]; 
%% 
for pNum = 1:length(validParticipants)
    participant = validParticipants(pNum);
    
    file = strcat('cleanData_', num2str(participant), '.mat');
    load(file)

    degtopix = 49.7;
    valid = ~isnan(testing.MouseX);
    testing = testing(valid, :);

    startTrial = find(testing.Noise > degtopix/10, 1, 'first');
        
    data = testing(startTrial:end, :);
    
    [params(pNum, :), fVal(pNum)] = fmincon(@(coef) continuous_bayes_sse(data, coef), init, [], [], [], [], lb, ub);
    %[paramsOnlyPrior(pNum, :), fValOnlyPrior(pNum)] = fmincon(@(coef) continuous_bayes_sse_withNoiseSD(data, coef), initOnlyPrior, [], [], [], [], lbOnlyPrior, ubOnlyPrior);
    
end

save('fits_sse_SD.mat', 'params', 'fVal')
%save('fits_sse_onlyPrior.mat', 'paramsOnlyPrior', 'fValOnlyPrior')