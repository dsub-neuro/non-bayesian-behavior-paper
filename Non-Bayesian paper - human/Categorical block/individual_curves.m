load('C:\Users\Divya\Documents\Divya data\Non-Bayesian paper\Categorical experiment - block\Valid data - Categorical\summary_allTrials_4P.mat')

%%
close all
bins = 0.125:0.25:4;
jmpspace = linspace(0, 4, 10000);

for ii = 17
    %no noise
    noNoiseFig = figure;
    plot(bins, baselinePsychBins(ii, :), 'ko', 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, baselinePsychCurves(ii, :), 'color', 'k', 'LineWidth', 2)
    hold on
    plot(bins, lowPriorNoNoisePsychBins(ii, :), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, lowPriorNoNoisePsychCurves(ii, :), 'color', [0 0.5 0.5], 'LineWidth', 2)
    hold on
    plot(bins, highPriorNoNoisePsychBins(ii, :), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, highPriorNoNoisePsychCurves(ii, :), 'color', [1 0.65 0], 'LineWidth', 2)
    yticks([0 0.25 0.5 0.75 1])
    xlim([0 2.5])
    title(num2str(ii))
    box off
    set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
    
    fileNameMat = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\MATLAB\Categorical individual curves\No noise\', num2str(ii), '.m');
    fileNameSVG = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\SVG\Categorical individual curves\No noise\', num2str(ii), '.svg');
    
    saveas(noNoiseFig, fileNameMat)
    saveas(noNoiseFig, fileNameSVG)
    

    %low noise
    lowNoiseFig = figure;
    plot(bins, lowPriorLowNoisePsychBins(ii, :), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, lowPriorLowNoisePsychCurves(ii, :), 'color', [0 0.5 0.5], 'LineWidth', 2)
    hold on
    plot(bins, highPriorLowNoisePsychBins(ii, :), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, highPriorLowNoisePsychCurves(ii, :), 'color', [1 0.65 0], 'LineWidth', 2)
    yticks([0 0.25 0.5 0.75 1])
    xlim([0 2.5])
    title(num2str(ii))
    box off
    set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
    
    fileNameMat = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\MATLAB\Categorical individual curves\Low noise\', num2str(ii), '.m');
    fileNameSVG = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\SVG\Categorical individual curves\Low noise\', num2str(ii), '.svg');
    
    saveas(lowNoiseFig, fileNameMat)
    saveas(lowNoiseFig, fileNameSVG)
   

    %high noise
    highNoiseFig = figure;
    plot(bins, lowPriorHighNoisePsychBins(ii, :), 'o', 'color', [0 0.5 0.5], 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, lowPriorHighNoisePsychCurves(ii, :), 'color', [0 0.5 0.5], 'LineWidth', 2)
    hold on
    plot(bins, highPriorHighNoisePsychBins(ii, :), 'o', 'color', [1 0.65 0], 'MarkerSize', 8, 'LineWidth', 1)
    hold on
    plot(jmpspace, highPriorHighNoisePsychCurves(ii, :), 'color', [1 0.65 0], 'LineWidth', 2)
    yticks([0 0.25 0.5 0.75 1])
    xlim([0 2.5])
    title(num2str(ii))
    box off
    set(gca, 'LineWidth', 1.5, 'FontSize', 15, 'Color', 'none', 'TickDir', 'out')
    
    fileNameMat = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\MATLAB\Categorical individual curves\High noise\', num2str(ii), '.m');
    fileNameSVG = strcat('C:\Users\Divya\Google Drive\Psychophysics paper\Figures\Supplementary\SVG\Categorical individual curves\High noise\', num2str(ii), '.svg');
    
    saveas(highNoiseFig, fileNameMat)
    saveas(highNoiseFig, fileNameSVG)
    
    
end
    