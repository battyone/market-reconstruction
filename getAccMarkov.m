function [ accMarkov ] = getAccMarkov( markov )

    % Get the size of the input argument (should be a NxN matrix)
    s = size(markov);
    if s(1) == s(2)
        % Pre-allocate the memory for the output accumulated matrix
        accMarkov = zeros(s(1),s(2));
        
        % Accumulate the probabilities and store them
        for i=1:s(1)
            sum = 0;
            for j=1:s(2)
                sum = sum + markov(i,j);
                accMarkov(i,j) = sum;
            end
        end
    else
        accMarkov = [];
    end

end

