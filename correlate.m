function [ corr, n, err ] = correlate( T, P, T_offset, ndays )
% This function finds the n-day returns correlation for a T-day window
% such as C( r(n), T ) = < r(t+T,n) r(t,n) >
    
    if nargin == 3
        % Default number of n-day period
        ndays = 1;
    end
    
    if length(P) == length(T)
    
        % Calculate delta
        err = 0;
        corr = zeros(T_offset,2);
        n = zeros(T_offset,2);

        [~, returns, err] = nDayReturns(T, P, ndays);
        
        for k=1:T_offset
            corr(k,1) = mean(returns(k:end).*returns(1:end-k+1));
            corr(k,2) = mean(abs(returns(k:end)).*abs(returns(1:end-k+1)));
            n(k,1) = k;
            n(k,2) = k;
        end
        
    else
        corr = [];
        n = [];
        err = 1;
    end
    
end

