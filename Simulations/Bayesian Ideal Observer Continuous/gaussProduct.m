function [mean, SD] = gaussProduct(mean1, SD1, mean2, SD2)

if SD1 == Inf 
    mean = mean2; 
elseif SD2 == Inf 
    mean = mean1; 
else
    mean = (((SD1^2).* mean2) + ((SD2^2).* mean1))/((SD1^2) + (SD2^2));
end
SD = sqrt(1/(1/(SD1^2) + (1/(SD2^2))));

end