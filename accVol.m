function [ time, acc ] = accVol( t, returns )
% Calculates the accumulated volatility

    % Get the number of points available
    N = length(returns);

    % Initialize
    acc = zeros(N,1);
    time = zeros(N,1);
    
    for i = 1:N
        acc(i) = std( returns(1:i) );
        time(i) = t(i);
    end

end

