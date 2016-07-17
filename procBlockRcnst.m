function [ forecast, err ] = procBlockRcnst( first_seq, sec_seq, K )

    useTrueRand = false;

    if nargin < 2
        % Must have at least 2 arguments to proceed
        err = 1;
        forecast = [];
    else
        if nargin == 2
            % Default size of the K-block
            K = 2;
        end
        
        % Find the size of the input arguments
        N1 = length(first_seq); % Used to compute the Markov matrix
        N2 = length(sec_seq); % Used for the forecast
        
        % Pre-allocate the memory for the resulting forecast
        fsize = N2 - K + 1;
        forecast = zeros(fsize, 1);
        
        % Get a vector of true random values from random.org
        if useTrueRand
            resolution = 10000;
            [ data, r_err ] = trueRand(N,1,resolution);
        else
            r_err = 1;
        end
        % Or use MATLAB's pseudo-random generator, if quota exceeded
        if r_err == 1
            randVec = rand(fsize,1);
            disp('Using pseudo-random numbers from MATLAB');
        else
            randVec = ( data - 1 ) ./ resolution;
            disp('Using true random numbers from random.org');
        end
        
        % Get the first Markov matrix
        % markov = k_markov(first_seq, K);
        % acc_k_markov = get_acc_k_markov(markov);
        
        % Get the accumulated Markov matrix for all K and K-i up to 2-block
        all_acc_markov = cell(K-1, 1);
        for i=1:K-1
            all_acc_markov{i} = get_acc_k_markov(k_markov(first_seq, K-i+1));
        end
        
        for i=K:N1
            acc_k_markov = all_acc_markov{1};
            starts = i - (K-1);
            ends = i - 1;
            k_block = fliplr(sec_seq(starts:ends)); % Grab the K-block
            prev = num2cell(k_block);
            
            % Get the accumulated probabilities given the K-Block
            accProb = acc_k_markov(:, prev{:});
            
            % Get the respective random value from the vector
            randVal = randVec(starts);
            
            % Find the forecasted value
            j = 1;
            k = 1;
            prob = 0;
            
            % Find where the random value lands in the accumulated prob
            while randVal > prob
                forecast(i) = j;
                prob = accProb(j);
                % Get the K-1 block if prob = 0
                while prob == 0
                    k_block = fliplr(sec_seq(starts:ends)); % Grab the K-1 block
                    prev = num2cell(k_block(1:length(k_block)-k));
                    k = k + 1;
                    acc_k_markov = all_acc_markov{k};
                    accProb = acc_k_markov(:, prev{:});
                    prob = accProb(j);
                end
                j = j + 1;
            end
        end
        
        err = 0;
    end

end

