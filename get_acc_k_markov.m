function [ acc_k_markov ] = get_acc_k_markov( k_markov )

    % Get the size of the K-Markov matrix and pre-allocate the variables
    s = size(k_markov);
    alphabet = s(1);
    N = numel(k_markov) ./ alphabet;
    acc_k_markov = zeros(s);
    
    for i=1:N
        sum = 0;
        for j=1:alphabet
            idx = alphabet * ( i - 1 ) + j;
            sum = sum + k_markov(idx);
            acc_k_markov(idx) = sum;
        end
    end
    
end

