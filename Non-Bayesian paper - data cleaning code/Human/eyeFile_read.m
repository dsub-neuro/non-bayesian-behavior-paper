function [time, xPos, yPos, PupD] = eyeFile_read(folder, P, expphase)
cd(folder)
currDir = dir('*.txt'); %get all text files in current folder
currDirName = {currDir.name};

time = NaN(length(currDirName)-1, 4000);
xPos = NaN(length(currDirName)-1, 4000);
yPos = NaN(length(currDirName)-1, 4000);
PupD = NaN(length(currDirName)-1, 4000);

if ~isempty(currDir) %if the folder is not empty
    for ii = 1:length(currDirName)-1
        %     ii = data.Var1(jj); %trial number
        filename = strcat(P, '_', expphase, '_eye', num2str(ii), '.txt'); %current file
        if contains(filename, 'eye') %eye position files
            if ~(exist(filename, 'file') == 2)
                time(ii, 1:4000) = NaN;
                xPos(ii, 1:4000) = NaN;
                yPos(ii, 1:4000) = NaN;
                PupD(ii, 1:4000) = NaN;
            else
                eyepos = readtable(filename);
                warning('off', 'all')
                if isempty(eyepos) || length(eyepos.Time) > 4000
                    time(ii, 1:4000) = NaN;
                    xPos(ii, 1:4000) = NaN;
                    yPos(ii, 1:4000) = NaN;
                    PupD(ii, 1:4000) = NaN;
                else
                    time(ii, 1:length(eyepos.Time)) = eyepos.Time;
                    xPos(ii, 1:length(eyepos.X_pos)) = eyepos.X_pos;
                    yPos(ii, 1:length(eyepos.Y_pos)) = eyepos.Y_pos;
                    PupD(ii, 1:length(eyepos.Pupil)) = eyepos.Pupil;
                end
            end
        end
    end
end

end