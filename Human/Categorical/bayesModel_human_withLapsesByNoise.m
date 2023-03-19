function err = bayesModel_human_withLapsesByNoise(data, coef)

%% assign variables to parameters in coef
noNoiseCoef = coef(1);
lowNoiseCoef = coef(2);
highNoiseCoef = coef(3);
jumpDistSD = coef(4);
noJumpDistSD = coef(5);
lowPriorOdds = coef(6);
medPriorOdds = coef(7);
highPriorOdds = coef(8);
noNoiseLowerBound = coef(9);
noNoiseLapse = coef(10);
lowNoiseLowerBound = coef(11);
lowNoiseLapse = coef(12);
highNoiseLowerBound = coef(13);
highNoiseLapse = coef(14);
%% set up final output structures
dataSize = size(data.Color, 1);
jProbNorm = NaN(dataSize, 1);

%% get trial info from
noiseLevels = unique(data.Noise);

trls90 = data.JProb  == 0.9;
clr90 = unique(data.Color(trls90));

trls10 = data.JProb == 0.1;
clr10 = unique(data.Color(trls10));

resp = data.Response/5;

noNoise = data.Noise == noiseLevels(1);
lowNoise = data.Noise == noiseLevels(2);
highNoise = data.Noise == noiseLevels(3);

lowPrior = data.Color == clr10;
medPrior = ~(data.Color == clr10) & ~(data.Color == clr90);
highPrior = data.Color == clr90;

jProbNorm(medPrior & noNoise) = bayes_decision_simulation_lapses(abs(data.JumpSize(medPrior & noNoise)), jumpDistSD, noJumpDistSD, noNoiseCoef, medPriorOdds, noNoiseLowerBound, noNoiseLapse);
jProbNorm(lowPrior & noNoise) = bayes_decision_simulation_lapses(abs(data.JumpSize(lowPrior & noNoise)), jumpDistSD, noJumpDistSD, noNoiseCoef, lowPriorOdds, noNoiseLowerBound, noNoiseLapse);
jProbNorm(highPrior & noNoise) = bayes_decision_simulation_lapses(abs(data.JumpSize(highPrior & noNoise)), jumpDistSD, noJumpDistSD, noNoiseCoef, highPriorOdds, noNoiseLowerBound, noNoiseLapse);

jProbNorm(lowPrior & lowNoise) = bayes_decision_simulation_lapses(abs(data.JumpSize(lowPrior & lowNoise)), jumpDistSD, noJumpDistSD, lowNoiseCoef, lowPriorOdds, lowNoiseLowerBound, lowNoiseLapse);
jProbNorm(highPrior & lowNoise) = bayes_decision_simulation_lapses(abs(data.JumpSize(highPrior & lowNoise)), jumpDistSD, noJumpDistSD, lowNoiseCoef, highPriorOdds, lowNoiseLowerBound, lowNoiseLapse);

jProbNorm(lowPrior & highNoise) = bayes_decision_simulation_lapses(abs(data.JumpSize(lowPrior & highNoise)), jumpDistSD, noJumpDistSD, highNoiseCoef, lowPriorOdds, highNoiseLowerBound, highNoiseLapse);
jProbNorm(highPrior & highNoise) = bayes_decision_simulation_lapses(abs(data.JumpSize(highPrior & highNoise)), jumpDistSD, noJumpDistSD, highNoiseCoef, highPriorOdds, highNoiseLowerBound, highNoiseLapse);


%% compare to actual responses
njProbNorm = 1 - jProbNorm;

jProbNorm0 = jProbNorm == 0;
jProbNorm(jProbNorm0) = 0.0001;
njProbNorm(jProbNorm0) = 0.9999;

njProbNorm0 = njProbNorm == 0;
njProbNorm(njProbNorm0) = 0.0001;
jProbNorm(njProbNorm0) = 0.9999;

pCr = resp.*jProbNorm + (1-resp).*njProbNorm;

err = -sum(log(pCr));
predJump = jProbNorm > 0.5;

end