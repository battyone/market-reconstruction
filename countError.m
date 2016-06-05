function [ output ] = countError( original, forecast )
% This function counts the difference between the original series
% and the forecasted series
    
    % Check the lengths for consistency
    A = length(original);
    B = length(forecast);
    
    if A == B
        % Calculate the error
        error = original - forecast;
        
        % Get the number of unique elements to count
        el = unique(error);
        N = length(el);
        % And prepare the offset to use tem as index
        offset = abs(min(el)) + 1;
        
        % Pre-allocate the array
        output = zeros(N, 2);
        output(:,1) = el;
        
        % Count the occurrencies
        for i=1:A
            index = error(i) + offset;
            output(index, 2) = output(index, 2) + 1;
        end
        
    else
        output = [];
    end
    
end

