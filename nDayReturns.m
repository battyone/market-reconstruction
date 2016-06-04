function [ Time , Returns , err ] = nDayReturns( t , Prc , ndays )
% This functioncalculates de n-day daily returns for the prices input
% such as r(t,n) = Log p(t+n) - Log p(t)

    if nargin == 2
        % Default number of n-day period
        ndays = 1;
    end

    if length(Prc) > ndays
        
        % Get the number of points available
        N = length(Prc);
        
        % Find the number of output points
        k = N - ndays;
        Returns = zeros(k-1,1);
        Time = zeros(k-1,1);
        
        for i = 1:k-1
            Returns(i) = log(Prc(i+ndays)) - log(Prc(i));
            Time(i) = t(i+ndays);
        end
        
        % No error
        err = 0;
        
    else

        % Error found
        Returns = [];
        Time = [];
        err = 1;

    end

end

