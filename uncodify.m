function [ predicted_r ] = uncodify( code, returns )
% Converts the code back to returns (predicted)

    % Get the returns' average
    r_avg = mean(returns);
    % Get the return's standard deviation
    r_std = std(returns);
    % Get the length of the sequence
    N = length(code);
    % Get the alphabet
    alpha = length(unique(code));
    % Get the number of intervals
    K = alpha - 1;
    % Find the central value
    offset = ( alpha - 1 ) / 2 + 1;
    % Pre-allocate the memory
    predicted_r = zeros(N,1);
    
    for i=1:N
        % Bring the coding back around 0
        G = code(i) - offset;
        % Calculate the predicted return
        predicted_r(i) = r_avg + ( 2 / K * r_std ) * G;
    end
    
end

