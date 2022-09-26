function [time, xEnd, yEnd] = eyepos_endpoints(timeIn, X_Pos, Y_Pos, data, degtopix)

xEnd = NaN(1, size(X_Pos,1));
yEnd = NaN(1, size(X_Pos,1));
time = NaN(1, size(X_Pos,1));


for ii = 1:size(X_Pos,1)
    xPos = X_Pos(ii,:)/degtopix;
    yPos = Y_Pos(ii,:)/degtopix;
    xVel = diff(xPos);
    %xVelSmooth = smooth(xVel, 11);
    if ~isnan(data.TargJmpTime(ii)) && ~isnan(nanmean(xPos))
        fixOff = data.FixOff(ii);
        sacStart = fixOff + find(abs(xPos(fixOff:end)) > 2.5, 1, 'first');
        indStart = 20 + sacStart + find(abs(xVel(sacStart:end)) < 0.04, 1, 'first');
        if isempty(sacStart) || isempty(indStart)
            xEnd(ii) = NaN;
            yEnd(ii) = NaN;
            time(ii) = NaN;
        else
        %indStart = data.TargJumpTime(ii) + find(abs(xVelSmooth(data.TargJumpTime(ii):end)) < 2, 1, 'first');
        indEnd = indStart+60;
        xEnd(ii) = nanmean(xPos(indStart:indEnd));
        yEnd(ii) = nanmean(yPos(indStart:indEnd));
        time(ii) = timeIn(ii, indStart);
        end
    else
        xEnd(ii) = NaN;
        yEnd(ii) = NaN;
        time(ii) = NaN; 
    end
end

end