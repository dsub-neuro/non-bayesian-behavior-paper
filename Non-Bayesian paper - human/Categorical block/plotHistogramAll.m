%all priors, no noise
errorbar(1:3, [mean(lowPriorNoNoiseParams.jumpMean) mean(baselineParams.jumpMean) mean(highPriorNoNoiseParams.jumpMean)], [std(lowPriorNoNoiseParams.jumpMean)/sqrt(20) std(baselineParams.jumpMean)/sqrt(20) std(highPriorNoNoiseParams.jumpMean)/sqrt(20)], 'ko')
hold on
errorbar(1:3, [mean(lowPriorNoNoiseParams.noJumpMean) mean(baselineParams.noJumpMean) mean(highPriorNoNoiseParams.noJumpMean)], [std(lowPriorNoNoiseParams.noJumpMean)/sqrt(20) std(baselineParams.noJumpMean)/sqrt(20) std(highPriorNoNoiseParams.noJumpMean)/sqrt(20)], 'ro')

errorbar(1:3, [mean(lowPriorNoNoiseParams.jumpSTD) mean(baselineParams.jumpSTD) mean(highPriorNoNoiseParams.jumpSTD)], [std(lowPriorNoNoiseParams.jumpSTD)/sqrt(20) std(baselineParams.jumpSTD)/sqrt(20) std(highPriorNoNoiseParams.jumpSTD)/sqrt(20)], 'ko')
hold on
errorbar(1:3, [mean(lowPriorNoNoiseParams.noJumpSTD) mean(baselineParams.noJumpSTD) mean(highPriorNoNoiseParams.noJumpSTD)], [std(lowPriorNoNoiseParams.noJumpSTD)/sqrt(20) std(baselineParams.noJumpSTD)/sqrt(20) std(highPriorNoNoiseParams.noJumpSTD)/sqrt(20)], 'ro')

%low prior all noise
figure
errorbar(1:3, [mean(lowPriorNoNoiseParams.jumpMean) mean(lowPriorLowNoiseParams.jumpMean) mean(lowPriorHighNoiseParams.jumpMean)], [std(lowPriorNoNoiseParams.jumpMean)/sqrt(20) std(lowPriorLowNoiseParams.jumpMean)/sqrt(20) std(lowPriorHighNoiseParams.jumpMean)/sqrt(20)], 'ko')
hold on
errorbar(1:3, [mean(lowPriorNoNoiseParams.noJumpMean) mean(lowPriorLowNoiseParams.noJumpMean) mean(lowPriorHighNoiseParams.noJumpMean)], [std(lowPriorNoNoiseParams.noJumpMean)/sqrt(20) std(lowPriorLowNoiseParams.noJumpMean)/sqrt(20) std(lowPriorHighNoiseParams.noJumpMean)/sqrt(20)], 'ro')
title('mean')

figure
errorbar(1:3, [mean(lowPriorNoNoiseParams.jumpSTD) mean(lowPriorLowNoiseParams.jumpSTD) mean(lowPriorHighNoiseParams.jumpSTD)], [std(lowPriorNoNoiseParams.jumpSTD)/sqrt(20) std(lowPriorLowNoiseParams.jumpSTD)/sqrt(20) std(lowPriorHighNoiseParams.jumpSTD)/sqrt(20)], 'ko')
hold on
errorbar(1:3, [mean(lowPriorNoNoiseParams.noJumpSTD) mean(lowPriorLowNoiseParams.noJumpSTD) mean(lowPriorHighNoiseParams.noJumpSTD)], [std(lowPriorNoNoiseParams.noJumpSTD)/sqrt(20) std(lowPriorLowNoiseParams.noJumpSTD)/sqrt(20) std(lowPriorHighNoiseParams.noJumpSTD)/sqrt(20)], 'ro')
title('std')

%% 
x = linspace(-4, 4, 10000);
baselineJump = NaN(20, 10000);
baselineNoJump = NaN(20, 10000);

lowPriorNoNoiseJump = NaN(20, 10000);
lowPriorNoNoiseNoJump = NaN(20, 10000);

lowPriorLowNoiseJump = NaN(20, 10000);
lowPriorLowNoiseNoJump = NaN(20, 10000);

lowPriorHighNoiseJump = NaN(20, 10000);
lowPriorHighNoiseNoJump = NaN(20, 10000);

highPriorNoNoiseJump = NaN(20, 10000);
highPriorNoNoiseNoJump = NaN(20, 10000);

highPriorLowNoiseJump = NaN(20, 10000);
highPriorLowNoiseNoJump = NaN(20, 10000);

highPriorHighNoiseJump = NaN(20, 10000);
highPriorHighNoiseNoJump = NaN(20, 10000);


for ii = 1:20
    baselineJump(ii, :) = normpdf(x, baselineParams.jumpMean(ii), baselineParams.jumpSTD(ii));
    baselineNoJump(ii, :) = normpdf(x, baselineParams.noJumpMean(ii), baselineParams.noJumpSTD(ii));

    lowPriorNoNoiseJump(ii, :) = normpdf(x, lowPriorNoNoiseParams.jumpMean(ii), lowPriorNoNoiseParams.jumpSTD(ii));
    lowPriorNoNoiseNoJump(ii, :) = normpdf(x, lowPriorNoNoiseParams.noJumpMean(ii), lowPriorNoNoiseParams.noJumpSTD(ii));

    lowPriorLowNoiseJump(ii, :) = normpdf(x, lowPriorLowNoiseParams.jumpMean(ii), lowPriorLowNoiseParams.jumpSTD(ii));
    lowPriorLowNoiseNoJump(ii, :) = normpdf(x, lowPriorLowNoiseParams.noJumpMean(ii), lowPriorLowNoiseParams.noJumpSTD(ii));

    lowPriorHighNoiseJump(ii, :) = normpdf(x, lowPriorHighNoiseParams.jumpMean(ii), lowPriorHighNoiseParams.jumpSTD(ii));
    lowPriorHighNoiseNoJump(ii, :) = normpdf(x, lowPriorHighNoiseParams.noJumpMean(ii), lowPriorHighNoiseParams.noJumpSTD(ii));

    highPriorNoNoiseJump(ii, :) = normpdf(x, highPriorNoNoiseParams.jumpMean(ii), highPriorNoNoiseParams.jumpSTD(ii));
    highPriorNoNoiseNoJump(ii, :) = normpdf(x, highPriorNoNoiseParams.noJumpMean(ii), highPriorNoNoiseParams.noJumpSTD(ii));

    highPriorLowNoiseJump(ii, :) = normpdf(x, highPriorLowNoiseParams.jumpMean(ii), highPriorLowNoiseParams.jumpSTD(ii));
    highPriorLowNoiseNoJump(ii, :) = normpdf(x, lowPriorLowNoiseParams.noJumpMean(ii), highPriorLowNoiseParams.noJumpSTD(ii));

    highPriorHighNoiseJump(ii, :) = normpdf(x, highPriorHighNoiseParams.jumpMean(ii), highPriorHighNoiseParams.jumpSTD(ii));
    highPriorHighNoiseNoJump(ii, :) = normpdf(x, lowPriorHighNoiseParams.noJumpMean(ii), highPriorHighNoiseParams.noJumpSTD(ii));


end

%% 
%no noise
figure
shadedErrorBar(x, mean(baselineJump), std(baselineJump)/sqrt(20))
hold on
shadedErrorBar(x, mean(baselineNoJump), std(baselineNoJump)/sqrt(20))
title('baseline, no noise')
ylim([0 7])

figure
shadedErrorBar(x, mean(lowPriorNoNoiseJump), std(lowPriorNoNoiseJump)/sqrt(20), 'LineProps', 'b')
hold on
shadedErrorBar(x, mean(lowPriorNoNoiseNoJump), std(lowPriorNoNoiseNoJump)/sqrt(20), 'LineProps', 'c')
title('0.1, no noise')
ylim([0 7])

figure
shadedErrorBar(x, mean(highPriorNoNoiseJump), std(highPriorNoNoiseJump)/sqrt(20), 'LineProps', 'r')
hold on
shadedErrorBar(x, mean(highPriorNoNoiseNoJump), std(highPriorNoNoiseNoJump)/sqrt(20), 'LineProps', 'm')
title('0.9, no noise')
ylim([0 7])

%low prior
figure
shadedErrorBar(x, mean(lowPriorLowNoiseJump), std(lowPriorLowNoiseJump)/sqrt(20), 'LineProps', 'b')
hold on
shadedErrorBar(x, mean(lowPriorLowNoiseNoJump), std(lowPriorLowNoiseNoJump)/sqrt(20), 'LineProps', 'c')
title('0.1, low noise')
ylim([0 7])

figure
shadedErrorBar(x, mean(lowPriorHighNoiseJump), std(lowPriorHighNoiseJump)/sqrt(20), 'LineProps', 'b')
hold on
shadedErrorBar(x, mean(lowPriorHighNoiseNoJump), std(lowPriorHighNoiseNoJump)/sqrt(20), 'LineProps', 'c')
title('0.1, high noise')
ylim([0 7])

%high prior
figure
shadedErrorBar(x, mean(highPriorLowNoiseJump), std(highPriorLowNoiseJump)/sqrt(20), 'LineProps', 'r')
hold on
shadedErrorBar(x, mean(highPriorLowNoiseNoJump), std(highPriorLowNoiseNoJump)/sqrt(20), 'LineProps', 'm')
title('0.9, low noise')
ylim([0 7])

figure
shadedErrorBar(x, mean(highPriorHighNoiseJump), std(highPriorHighNoiseJump)/sqrt(20), 'LineProps', 'r')
hold on
shadedErrorBar(x, mean(highPriorHighNoiseNoJump), std(highPriorHighNoiseNoJump)/sqrt(20), 'LineProps', 'm')
title('0.9, high noise')
ylim([0 7])

