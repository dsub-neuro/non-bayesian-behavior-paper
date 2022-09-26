cleanData.validResp = [];
cleanData.jumpSize = [];
cleanData.isJump = [];
cleanData.resp = [];
cleanData.noise = [];
cleanData.color = [];
cleanData.sacDir = [];
cleanData.responseSaccadeX = [];
cleanData.responseSaccadeY = [];
cleanData.thresh = [];
cleanData.fixLoc = [];
cleanData.targLoc = [];
cleanData.preProbe = [];
cleanData.postProbe = [];
cleanData.interveningSaccadeEnd = []; 
cleanData.interveningSaccadeStart = []; 
cleanData.session = [];
%Toki dates - prior + noise
dates = {'31-Mar-2020', '01-Apr-2020-01', '01-Apr-2020-02', '01-Apr-2020', '02-Apr-2020', '03-Apr-2020-01', '03-Apr-2020', '06-Apr-2020', '07-Apr-2020-01', '07-Apr-2020-02', '07-Apr-2020', '08-Apr-2020-01', '08-Apr-2020', '09-Apr-2020-01', '09-Apr-2020', '10-Apr-2020-01', '10-Apr-2020-02', '10-Apr-2020', '13-Apr-2020', '14-Apr-2020', '15-Apr-2020-01', '15-Apr-2020', '16-Apr-2020-01', '16-Apr-2020', '17-Apr-2020', '20-Apr-2020-01', '20-Apr-2020', '21-Apr-2020-01', '21-Apr-2020', '22-Apr-2020', '23-Apr-2020'};
%Toki - d' curve dates
%dates = {'14-Jan-2020', '15-Jan-2020', '16-Jan-2020-01', '16-Jan-2020', '17-Jan-2020-01', '17-Jan-2020', '20-Jan-2020', '21-Jan-2020', '22-Jan-2020', '23-Jan-2020', '24-Jan-2020-01', '24-Jan-2020', '27-Jan-2020', '28-Jan-2020', '29-Jan-2020', '31-Jan-2020', '03-Feb-2020', '05-Feb-2020', '07-Feb-2020', '10-Feb-2020', '11-Feb-2020', '12-Feb-2020', '13-Feb-2020', '14-Feb-2020'}; 
%{'17-Feb-2020', '19-Feb-2020', '20-Feb-2020', '21-Feb-2020', '22-Feb-2020-01', '22-Feb-2020-02', '25-Feb-2020', '26-Feb-2020-01', '26-Feb-2020-02', '26-Feb-2020-03', '27-Feb-2020', '28-Feb-2020', '04-Mar-2020', '05-Mar-2020', '06-Mar-2020-01', '06-Mar-2020-02', '09-Mar-2020', '10-Mar-2020', '11-Mar-2020-01', '11-Mar-2020', '12-Mar-2020', '14-Mar-2020', '16-Mar-2020-01', '16-Mar-2020', '17-Mar-2020-01', '17-Mar-2020', '18-Mar-2020-01', '18-Mar-2020', '19-Mar-2020-01', '19-Mar-2020', '20-Mar-2020-01', '20-Mar-2020', '23-Mar-2020-01', '23-Mar-2020-02', '24-Mar-2020-01', '24-Mar-2020'};

%Skwiz dates - prior + noise
%dates = {'14-Jan-2020', '20-Jan-2020', '21-Jan-2020', '23-Jan-2020', '24-Jan-2020', '27-Jan-2020', '28-Jan-2020', '29-Jan-2020', '31-Jan-2020'};
%dates for Skwiz behavioral version, d' curve, noise = 0.5
%dates = {'10-Dec-2019', '11-Dec-2019', '13-Dec-2019', '16-Dec-2019', '18-Dec-2019', '19-Dec-2019', '20-Dec-2019', '23-Dec-2019', '24-Dec-2019', '25-Dec-2019', '26-Dec-2019', '27-Dec-2019', '30-Dec-2019', '02-Jan-2020','03-Jan-2020', '06-Jan-2020', '07-Jan-2020', '08-Jan-2020', '09-Jan-2020', '10-Jan-2020'};
    %{'13-Jan-2020', '14-Jan-2020', '20-Jan-2020', '21-Jan-2020', '23-Jan-2020', '24-Jan-2020', '27-Jan-2020', '28-Jan-2020', '29-Jan-2020', '31-Jan-2020'};


%session = 54;
for ii = 1:length(dates)
    filename = strcat(dates{ii}, '.mat');
    load(filename)
    
    cleanData1 = monkey_ssd_cleanData(sessionData, trialData);
%     cleanData1.session = NaN(length(cleanData1.validResp), 1);
%     cleanData1.session(:) = session;
    
    cleanData.validResp = [cleanData.validResp; cleanData1.validResp];
    cleanData.jumpSize = [cleanData.jumpSize; cleanData1.jumpSize];
    cleanData.isJump = [cleanData.isJump; cleanData1.isJump];
    cleanData.resp = [cleanData.resp; cleanData1.resp];
    cleanData.noise = [cleanData.noise; cleanData1.noise];
    cleanData.color = [cleanData.color; cleanData1.color];
    cleanData.sacDir = [cleanData.sacDir; cleanData1.sacDir];
    cleanData.responseSaccadeX = [cleanData.responseSaccadeX; cleanData1.responseSaccadeX];
    cleanData.responseSaccadeY = [cleanData.responseSaccadeY; cleanData1.responseSaccadeY];
    cleanData.thresh = [cleanData.thresh; cleanData1.thresh];
    cleanData.fixLoc = [cleanData.fixLoc; cleanData1.fixLoc];
    cleanData.targLoc = [cleanData.targLoc; cleanData1.targLoc];
    cleanData.preProbe = [cleanData.preProbe; cleanData1.preProbe];
    cleanData.postProbe = [cleanData.postProbe; cleanData1.postProbe];
    cleanData.interveningSaccadeEnd = [cleanData.interveningSaccadeEnd; cleanData1.interveningSaccadeEnd]; 
    cleanData.interveningSaccadeStart = [cleanData.interveningSaccadeStart; cleanData1.interveningSaccadeStart]; 
    cleanData.session = [cleanData.session; cleanData1.session];
    
    
    session = session + 1;
end


