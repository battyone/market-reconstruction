function [ markov, N, err ] = markovMatrix( codedData )
    
    err = 0;
    
    % Get the number of data points
    n = length(codedData);
    
    % Get the number of unique elements (the alphabet length)
    index = unique(codedData);
    alpha = length(index);
    
    % Get the absolute frequency of each element
    % freq = [index, histc(codedData(:), index)];
    
    % Calculate the respective probabilities
    % prob = freq;
    % prob(:,2) = prob(:,2) ./ n;
    
    % Calculate the 2-sequence probabilities
    % and the (alpha x alpha) Markov matrix
    markov = zeros(alpha, alpha);
    seqCount = zeros(alpha, alpha);
    seqPrev = zeros(alpha, 1);
    N = floor(n/2);
    
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
