function [loglike] = likelihood_trial(bhat,Y,ht,neu);

% Dimension of Y
[CHN SMP TRL] = size(Y);

% Binomial case
loglike = 0;
[CHN SAM TRL] = size(Y);
for itrial = 1:TRL  
    
    temp = ones(SAM-ht,1);
    for ichannel = 1:CHN 
        for hh = 0:3:ht-3
            temp0 = Y(ichannel,ht-hh:SAM-1-hh,itrial)' + Y(ichannel,ht-1-hh:SAM-2-hh,itrial)' + Y(ichannel,ht-2-hh:SAM-3-hh,itrial)';
            temp = [temp temp0];
        end
    end
    ETA = temp*bhat;
    P = exp(ETA)./(1+exp(ETA));
    
    for isample = ht+1:SAM              
        % changed from isample = 60+1:SAM to isample = ht+1:SAM on 2019-08-24
            % isample = max_ht_order+1?
        loglike = loglike + Y(neu,isample,itrial)*log(P(isample-ht)) + (1-Y(neu,isample,itrial))*log(1-P(isample-ht));
    end
    
end