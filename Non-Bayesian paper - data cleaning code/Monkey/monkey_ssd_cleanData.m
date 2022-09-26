function cleanData = monkey_ssd_cleanData(sessionData, trialData)
%returns trial and eye position data for trials with a response (no jump or jump including
%early response) and trials where probe moved before saccade endpoint
%sessionData = session parameters
%trialData = eye position and photodiode per trial
%TASK STRUCTURE: fix on (photo1) + 300-500ms fixation + probe on (photo2) + 500-700ms
%probeFixDur + targ on + saccade reaction time + targ moves (photo3) +
%700ms postSacFixTime + cross on (photo4) + 1000ms if no jump/500ms to make
%sac if jump

sessionData = sessionData.sessionData;
if mod(size(trialData.Photodiode, 1), 10) == 0
    nTrials = size(trialData.Photodiode, 1);
else
    nTrials = size(trialData.Photodiode, 1) - mod(size(trialData.Photodiode, 1), 10);
end

fixLoc = NaN(nTrials, 2); %X-Pos, Y-Pos in degrees
targLoc = NaN(nTrials, 2); %X-Pos, Y-Pos in degrees
preProbe = NaN(nTrials, 2);
postProbe = NaN(nTrials, 2);
validResp = zeros(nTrials, 1); %not valid, early, or valid
sacDir = NaN(nTrials, 1);
interveningSaccade = NaN(nTrials, 701); %target on + 700ms
reportingSaccadeX = NaN(nTrials, 1501); %intervening saccade endpoint + 1500
reportingSaccadeY = NaN(nTrials, 1501); %intervening saccade endpoint + 1500
interveningSaccadeEnd = NaN(nTrials, 1); 
interveningSaccadeStart = NaN(nTrials, 1);

isWithinSaccade = zeros(nTrials, 1);
resp = NaN(nTrials, 1);
degtopix = 24;

%%
%get valid responses (including early responses) and trials with jump within saccade
for trialNum = 1:nTrials
    %photodiode events
    photoEvents = find(diff(trialData.Photodiode(trialNum, :)) < -1);
    if length(photoEvents) > 2 %if reafferent target came on
        %get fix, probe and targ locations in degrees relative to the center of the
        %screen
        fixLoc(trialNum, 1) = -(1920/2 - sessionData.fixLocStore(trialNum, 1))/degtopix; %X position in degrees relative to center of screen. 0-1920 from left to right.
        fixLoc(trialNum, 2) = (1080/2 - sessionData.fixLocStore(trialNum, 2))/degtopix; %Y position in degrees relative to center of screen. 0-1080 from top to bottom.
        
        preProbe(trialNum, 1) = -(1920/2 - sessionData.probeLocStore(trialNum, 1))/degtopix; %X position in degrees relative to center of screen. 0-1920 from left to right.
        preProbe(trialNum, 2) = (1080/2 - sessionData.probeLocStore(trialNum, 2))/degtopix; %Y position in degrees relative to center of screen. 0-1080 from top to bottom.
        
        postProbe(trialNum, 1) = -(1920/2 - sessionData.probeLocStore(trialNum, 3))/degtopix; %X position in degrees relative to center of screen. 0-1920 from left to right.
        postProbe(trialNum, 2) = (1080/2 - sessionData.probeLocStore(trialNum, 4))/degtopix; %Y position in degrees relative to center of screen. 0-1080 from top to bottom.
        
        targLoc(trialNum, 1) = -(1920/2 - sessionData.targLocStore(trialNum, 1))/degtopix; %X position in degrees relative to center of screen. 0-1920 from left to right.
        targLoc(trialNum, 2) = (1080/2 - sessionData.targLocStore(trialNum, 2))/degtopix; %Y position in degrees relative to center of screen. 0-1080 from top to bottom.
        
        %start of intervening saccade = probe on + 20ms pause in code + probe fixation duration
        sacStart = photoEvents(2) + 20 + sessionData.probeFixDurStore(trialNum)*1000;
        
%         %get direction of intervening saccade
%         if fixLoc(trialNum, 1) == targLoc(trialNum, 1) && fixLoc(trialNum, 2) == targLoc(trialNum, 2)
%             sacDir(trialNum) = 0;
%         elseif abs(targLoc(trialNum, 1) - fixLoc(trialNum, 1)) < abs(targLoc(trialNum, 2) - fixLoc(trialNum, 2)) %more vertical 
%             sacDir(trialNum) = 1; %vertical
%             interveningSaccade(trialNum, :) = trialData.YPos(trialNum, sacStart:sacStart+700);
%         elseif abs(targLoc(trialNum, 1) - fixLoc(trialNum, 1)) > abs(targLoc(trialNum, 2) - fixLoc(trialNum, 2)) %more vertical 
%             sacDir(trialNum) = 3; %horizontal
%             interveningSaccade(trialNum, :) = trialData.XPos(trialNum, sacStart:sacStart+700);
%         end
        
        %get direction of intervening saccade
        if fixLoc(trialNum, 1) == targLoc(trialNum, 1) && fixLoc(trialNum, 2) == targLoc(trialNum, 2)
            sacDir(trialNum) = 0;
        elseif fixLoc(trialNum, 1) == targLoc(trialNum, 1) && ~(fixLoc(trialNum, 2) == targLoc(trialNum, 2))
            sacDir(trialNum) = 1; %vertical
            interveningSaccade(trialNum, :) = trialData.YPos(trialNum, sacStart:sacStart+700);
        elseif ~(fixLoc(trialNum, 1) == targLoc(trialNum, 1)) && fixLoc(trialNum, 2) == targLoc(trialNum, 2)
            sacDir(trialNum) = 3; %horizontal
            interveningSaccade(trialNum, :) = trialData.XPos(trialNum, sacStart:sacStart+700);
        end
        
        
        if sacDir(trialNum) == 0
            isWithinSaccade(trialNum) = 1;
        else
            %get velocity of intervening saccade and find start and end points
            sacVel = diff(interveningSaccade(trialNum, :));
            sacVelStart = find(abs(sacVel) > 0.2, 1, 'first') + 1;
            if ~isempty(sacVelStart) && sacVelStart > 20 && sacVelStart < 500 %if true saccade and not spurious exiting of window after time limit
                sacEnd = find(abs(sacVel(sacVelStart:end)) < 0.04, 1, 'first'); %find saccade endpoint from start of saccade to end
                %get index (temporal) of saccade endpoint
                sacEndInd = sacStart + sacVelStart + sacEnd; %start of intervening saccade + start of detected velocity change + index of saccade end
                interveningSaccadeEnd(trialNum) = interveningSaccade(trialNum, sacEndInd - sacStart);
                interveningSaccadeStart(trialNum) = mean(interveningSaccade(trialNum, (sacVelStart-20):sacVelStart));
                %check if reafferent photo event + screen refresh time (7) precedes saccade endpoint
                if photoEvents(3) + 7 < sacEndInd
                    isWithinSaccade(trialNum) = 1;
                end
            end
        end
                
        %get reporting saccade relative to moved stimulus time
        reportingSaccadeX(trialNum, :) = trialData.XPos(trialNum, photoEvents(3):photoEvents(3) + 1500);
        reportingSaccadeY(trialNum, :) = trialData.YPos(trialNum, photoEvents(3):photoEvents(3) + 1500);
        %find valid trials and trials with early responses
        if length(photoEvents) == 4 %cross on making it legal to saccade
            validResp(trialNum) = 1; %valid trial
            if sessionData.isJumpStore(trialNum) == 1 && sessionData.successTrials(trialNum) == 1
                resp(trialNum) = 1;
            elseif sessionData.isJumpStore(trialNum) == 0 && sessionData.successTrials(trialNum) == 1
                resp(trialNum) = 0;
            elseif sessionData.isJumpStore(trialNum) == 1 && sessionData.successTrials(trialNum) == 0
                resp(trialNum) = 0;
            elseif sessionData.isJumpStore(trialNum) == 0 && sessionData.successTrials(trialNum) == 0
                resp(trialNum) = 1;
            end
        elseif length(photoEvents) == 3 && sacDir(trialNum) == 1 %vertical
            repSac = reportingSaccadeX(trialNum, 1:520);
            if max(abs(diff(repSac))) > 0.2
                validResp(trialNum) = 2; %early response
                resp(trialNum) = 1;
            end
        elseif length(photoEvents) == 3 && sacDir(trialNum) == 3 %horizontal
            repSac = reportingSaccadeY(trialNum, 1:520);
            if max(abs(diff(repSac))) > 0.2
                validResp(trialNum) = 2; %early response
                resp(trialNum) = 1;
            end
        end   
        
    end %if trial where probe moved loop
end %trials loop

%%
cleanTrials = (validResp > 0) & logical(isWithinSaccade);
cleanData.validResp = validResp(cleanTrials);
cleanData.jumpSize = sessionData.jumpSizeStore(cleanTrials);
cleanData.isJump = sessionData.isJumpStore(cleanTrials);
cleanData.resp = resp(cleanTrials);
cleanData.noise = sessionData.noiseValStore(cleanTrials);
cleanData.color = sessionData.colorStore(cleanTrials, :);
cleanData.sacDir = sacDir(cleanTrials);
cleanData.responseSaccadeX = reportingSaccadeX(cleanTrials, :);
cleanData.responseSaccadeY = reportingSaccadeY(cleanTrials, :);
cleanData.thresh = sessionData.threshValStore(cleanTrials);
cleanData.fixLoc = fixLoc(cleanTrials, :);
cleanData.targLoc = targLoc(cleanTrials, :);
cleanData.preProbe = preProbe(cleanTrials, :);
cleanData.postProbe = postProbe(cleanTrials, :);
cleanData.interveningSaccadeEnd = interveningSaccadeEnd(cleanTrials); 
cleanData.interveningSaccadeStart = interveningSaccadeStart(cleanTrials); 

end