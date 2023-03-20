%% slopes fit to empirical data
%in direction of saccade, right jumps
pNoInSacRight = NaN(11, 2);
pLowInSacRight = NaN(11, 2);
pHighInSacRight = NaN(11, 2);
pInfInSacRight = NaN(11, 2);

%in direction of saccade, left jumps
pNoInSacLeft = NaN(11, 2);
pLowInSacLeft = NaN(11, 2);
pHighInSacLeft = NaN(11, 2);
pInfInSacLeft = NaN(11, 2);

%opposite to direction of saccade, right jumps
pNoOppSacRight = NaN(11, 2);
pLowOppSacRight = NaN(11, 2);
pHighOppSacRight = NaN(11, 2);
pInfOppSacRight = NaN(11, 2);

%opposite to direction of saccade, left jumps
pNoOppSacLeft = NaN(11, 2);
pLowOppSacLeft = NaN(11, 2);
pHighOppSacLeft = NaN(11, 2);
pInfOppSacLeft = NaN(11, 2);


validParticipants = [1:2, 4, 6, 8:14];

for pNum = 1:length(validParticipants)
    participant = validParticipants(pNum);
    
    file = strcat('cleanData_', num2str(participant), '.mat');
    load(file)
    
    [pNoInSacRight(pNum, :), pLowInSacRight(pNum, :), pHighInSacRight(pNum, :), pInfInSacRight(pNum, :)] = continuous_lineFits_inVsOppSac_rightOrLeft(testing, 1, 1);
    [pNoInSacLeft(pNum, :), pLowInSacLeft(pNum, :), pHighInSacLeft(pNum, :), pInfInSacLeft(pNum, :)] = continuous_lineFits_inVsOppSac_rightOrLeft(testing, 1, -1);
    [pNoOppSacRight(pNum, :), pLowOppSacRight(pNum, :), pHighOppSacRight(pNum, :), pInfOppSacRight(pNum, :)] = continuous_lineFits_inVsOppSac_rightOrLeft(testing, -1, 1);
    [pNoOppSacLeft(pNum, :), pLowOppSacLeft(pNum, :), pHighOppSacLeft(pNum, :), pInfOppSacLeft(pNum, :)] = continuous_lineFits_inVsOppSac_rightOrLeft(testing, -1, -1);   
    
end

%% 
save('inSacRightFits.mat', 'pNoInSacRight', 'pLowInSacRight', 'pHighInSacRight', 'pInfInSacRight')
save('inSacLeftFits.mat', 'pNoInSacLeft', 'pLowInSacLeft', 'pHighInSacLeft', 'pInfInSacLeft')

save('oppSacRightFits.mat', 'pNoOppSacRight', 'pLowOppSacRight', 'pHighOppSacRight', 'pInfOppSacRight')
save('oppSacLeftFits.mat', 'pNoOppSacLeft', 'pLowOppSacLeft', 'pHighOppSacLeft', 'pInfOppSacLeft')
