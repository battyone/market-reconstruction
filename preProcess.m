function [ Time , Prices , err ] = preProcess( t , Prc , n )
% This function pre-processes the princes input
% by detrending using a n-polynomial fit and then rescaling
% such as x(t) = p(t) x < p(t) > / q(t)

    if nargin == 2
        % Default polynomial degree
        n = 3;
    end
    
    if length(t) == length(Prc)

        % Get the nth polynomial fit for the data
        [p, S, mu] = polyfit(t,Prc,n);
        poly = polyval(p,t,S,mu);

        % Detrending and rescaling
        avgP = mean(Prc);
        dP = Prc - poly;
        Time = t;
        Prices = ( dP ./ poly ) * avgP + avgP;
        
        % No error
        err = 0;

    else

        % Error found
        Time = [];
        Prices = [];
        err = 1;

    end

end

