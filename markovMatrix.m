function [ markov, err ] = markovMatrix( codedData )
    
    err = 0;
    
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
        seqCount(prev,this) = seqCount(prev,this) + 1;
        seqPrev(prev) = seqPrev(prev) + 1;
    end
    
    for i=1:alpha
        markov(i,:) = seqCount(i,:) ./ seqPrev(i);
    end
    
end