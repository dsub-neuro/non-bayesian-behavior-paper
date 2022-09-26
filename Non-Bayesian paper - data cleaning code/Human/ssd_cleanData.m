function [data, time, xEnd, yEnd, cleanRatio] = ssd_cleanData(data, time, xEnd, yEnd, degtopix, frames)
%returns a dataset that excludes trials on which the target did not jump
%within one frame of the saccade endpoint and trials on which the endpoint
%was greater than 4 degrees from the pre-saccdic location
%for continuous experiment
validResp = ~(isnan(data.MouseX));
%validResp = ~(isnan(data.RSP)) & ~(data.RSP > 5);
validIndex = find(validResp == 1);
xEnd = xEnd(validIndex);
yEnd = yEnd(validIndex);
time = time(validIndex);
data = data(validIndex, :);
denom = size(data, 1);

TargLoc = data.Targloc/degtopix + data.Side;
xEndPoints = xEnd;
yEndPoints = yEnd;
xDiff = TargLoc - xEndPoints';
yDiff = yEndPoints'; 

% validX = abs(xDiff) <= 5;
% validY = abs(yDiff) <= 5;

targJump = data.TargJmpTime;
timeDiff = time' - targJump; 
validTime = timeDiff >= (1000/frames);

%valid = validX & validY & validTime;
valid = validTime;

data = data(valid, :);
xEnd = xEnd(valid);
yEnd = yEnd(valid); 
time = time(valid); 
num = size(data, 1);
cleanRatio = num/denom;
end