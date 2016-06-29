function [ markov ] = k_markov( codedData, K )
% This function computes the K-block Markov matrix of
% the K-block empirical transition probabilities from
% the previously coded data

    if nargin == 1
        % Default size of the K-block
        K = 2;
    end

    % Get the number of data points
    N = length(codedData);
    
    % Get the number of unique elements (the alphabet length)
    index = unique(codedData);
    alpha = length(index);
    
    % Determine the size of the Markov matrix as [a_1 a_2 ... a_K],
    % where a_1 = a_2 = ... = a_k = size of the alphabet K times to
    % construct the 'a by a by a by ... by a' K-dimensional Markov matrix
    size = ones(1, K) * alpha;
    size2 = ones(1, K-1) * alpha;
    
    % Pre-allocate the variables into memory
    if K > 2
        markov = zeros(size); % To store the Markov matrix
        seqCount = zeros(size); % To count the frequencies
        seqPrev = zeros(size2); % To divide the frequencies
    else
        markov = zeros(alpha); % To store the Markov matrix
        seqCount = zeros(alpha); % To count the frequencies
        seqPrev = zeros(alpha, 1); % To divide the frequencies
    end
    
    % Algorithm for the Markov matrix
    for i=K:N
        starts = i - (K-1);
        ends = i - 1;
        k_block = codedData(starts:ends); % Grab the K-block
        subcell = num2cell(k_block);
        this = codedData(i);
        seqCount(subcell{:},this) = seqCount(subcell{:},this) + 1;
        seqPrev(subcell{:}) = seqPrev(subcell{:}) + 1;
    end
    
    % Convert the frequencies into probabilities
    %for i=1:alpha
    %    markov(i,:) = seqCount(i,:) ./ seqPrev(i);
    %end

end
