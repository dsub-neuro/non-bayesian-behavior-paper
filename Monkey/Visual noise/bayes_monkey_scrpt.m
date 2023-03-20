lb = [0, 0, 0, -100, -100, -100, 0, 0, 0, 0, 0, 0, 0, 0];
ub = [10, 10, 10, 100, 100, 100, 1, 1, 1, 1, 1, 1, 10, 10];
init = [1, 0.5, 0.1, 0, 0, 0, 0.001, 0.05, 0.001, 0.1, 0.001, 0.2, 0.2, 2.5];


[params, fVal] = fmincon(@(coef) bayesModel_monkey_withLapsesByNoise(cleanData, coef), init, [], [], [], [], lb, ub);


%%

params = array2table(params, 'VariableNames', {'noNoise', 'lowNoise', 'highNoise', 'lowPriorOdds', 'medPriorOdds', 'highPriorOdds', 'noNoiseLowerBound', 'noNoiseLapse', 'lowNoiseLowerBound', 'lowNoiseLapse', 'highNoiseLowerBound', 'highNoiseLapse', 'noJumpDist', 'jumpDist'});

save('bayesModel_logOddswithLapses_freeJumpDists.mat', 'params', 'fVal')
