function [ forecast, err ] = procRcnst( markov, sequence )

    if nargin == 2
        % Find the size of the input argument markov
        s = size(markov);
        if s(1) == s(2)
            % The Markov matrix is NxN
            N = length(sequence);
            % Pre-allocate the memory for the resulting forecast
            forecast = zeros(N,1);
            % Get the accumulated Markov matrix
            accMarkov = getAccMarkov(markov);
            % Get a vector of true random values from random.org
            resolution = 10000;
            [ data, err ] = trueRand(N,1,resolution);
            % Or use MATLAB's pseudo-random generator, if quota exceeded
            if err == 1
                randVec = rand(N,1);
                disp('Using pseudo-random numbers');
            else
                randVec = ( data - 1 ) ./ resolution;
                disp('Using true random numbers');
            end
            
            for i=1:N
                % Get the true value from the coded sequence
                trueValue = sequence(i);
                % Get the accumulated probability for the next value, given
                % the true value
                accProb = accMarkov(trueValue,:);
                % Get the respective random value from the vector
                randVal = randVec(i);
                % Find the forecasted value
                j = 1;
                prob = 0;
                % Find where the random value lands in the accumulated prob
                while randVal > prob
                    forecast(i) = j;
                    prob = accProb(j);
                    j = j + 1;
                end
            end
            
            % No error found
            err = 0;
            
        else
            % The Markov matrix must be a square matrix
            err = 1;
            forecast = [];
        end
        
    else
        % Must have exactly 2 arguments to proceed
        err = 1;
        forecast = [];
    end
    
end

