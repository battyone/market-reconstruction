function [ Time, Volatility, Acc, err ] = histVol( t, returns, ndays )
% Returns the historical volatility for n-day return periods

    if nargin == 2
        % Default number of n-day period
        ndays = 10;
    end

    if isnumeric(ndays)
        if length(returns) > ndays

            % Get the number of points available
            N = length(returns);

            % Find the number of output points
            k = fix(N/ndays);
            
            Volatility = zeros(k-1,1);
            Acc = zeros(k,1);
            Time = zeros(k-1,1);

            for i = 1:k-1
                
                sum_all = 0;
                flag = i * ndays;
                
                for j = 1:ndays
                    sum_all = sum_all + returns(flag+j-1);
                end
                
                avg_r = sum_all ./ ndays;
                dev = 0;
                
                for j = 1:ndays
                    dev = dev + ( returns(flag+j-1) - avg_r ).^2;
                end
                
                Volatility(i) = sqrt( dev ./ ndays );
                Acc(i+1) = Acc(i) + Volatility(i);
                Time(i) = t(flag);
                err = 0;
                
            end
            
            Acc = Acc(2:end);
            
        else
            Time = [];
            Volatility = [];
            Acc = [];
            err = 1;
        end
    else
        Time = [];
        Volatility = [];
        Acc = [];
        err = 1;
    end

end

