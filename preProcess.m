function [ Time , Prices , err ] = preProcess( t , Prc , n )

    if nargin == 2
        % Default polynomial degree
        n = 7;
    end
    
    if length(t) == length(Prc)

        % Get the nth polynomial fit for the data
        [p, S, mu] = polyfit(t,Prc,n);
        poly = polyval(p,t,S,mu);

        % Detrending and rescaling
        avgP = mean(Prc);
        Time = t;
        Prices = ( Prc ./ poly ) * avgP;
        
        % No error
        err = 0;

    else

        % Error found
        Time = [];
        Prices = [];
        err = 1;

    end

end

