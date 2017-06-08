function [ prices ] = returnsToPrices( returns, p0 )
% Converts returns back to prices

    if nargin == 1
        % Default the initial price to 1
        p0 = 1;
    end
    
    % Get the length of the returns
    N = length(returns);
    % Pre-allocate the memory
    prices = zeros(N,1);
    % Set the first price to p0
    prev = p0;
    
    for i=1:N
        prices(i) = prev * exp( returns(i) );
        prev = prices(i);
    end

end

