function [ Time , Prices , err ] = nDayReturns( t , Prc , ndays )

    if length(Prc) > ndays
        
        % Get the number of points available
        N = length(Prc);
        
        % Find the number of output points
        k = N - ndays;
        Prices = zeros(k-1,1);
        Time = zeros(k-1,1);
        
        for i = 1:k-1
            Prices(i) = log(Prc(i+ndays)) - log(Prc(i));
            Time(i) = t(i);
        end
        
        % No error
        err = 0;
        
    else

        % Error found
        Prices = [];
        Time = [];
        err = 1;

    end

end

