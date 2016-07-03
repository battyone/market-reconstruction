function [ markov ] = markovMatrix( codedData )
% This function calculates the Markov probability matrix for the coded data
    
    % Get the number of data points
    N = length(codedData);
    
    % Get the number of unique elements (the alphabet length)
    index = unique(codedData);
    alpha = length(index);
    
    % Pre-allocate the variables into memory
    markov = zeros(alpha, alpha); % To store the Markov matrix
    seqCount = zeros(alpha, alpha); % To count the frequencies
    seqPrev = zeros(alpha, 1); % To divide the frequencies
    
    % Algorithm for the Markov matrix
    for i=2:N
        prev = codedData(i-1);
        this = codedData(i);
        % Count the frequencies
        seqCount(this, prev) = seqCount(this, prev) + 1; % X | [...]
        seqPrev(prev) = seqPrev(prev) + 1; % | [...]
    end
    
    % Convert the frequencies into probabilities
    for i=1:alpha
        % P( X | [...] )
        X = index(i);
        for j=1:alpha
            prev = index(j);
            markov(X, prev) = seqCount(X, prev) ./ seqPrev(prev);
        end
    end
    
end
