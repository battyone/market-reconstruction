function [ seq, err ] = procRcnst( markov, N )

    if nargin == 2
        s = size(markov);
        if s(1) == s(2)
            % Create a map of probabilities
            K = s(1);
            mapProb = zeros(K,K);
            for i=1:K
                last = 0;
                for j=1:K
                    mapProb(i,j) = last + markov(i,j);
                    last = mapProb(i,j);
                end
            end
            
            % Get a random tuple [XY]
            seq = zeros(N,1);
            seq(1) = randi(K);
            
            for i=2:N
                prev = seq(i-1);
                rnd = rand;
                for j=1:K;
                    idx = K-j+1;
                    if rnd < mapProb(prev, idx)
                        seq(i) = idx;
                    end
                end
            end
            
        else
            % The Markov matrix must be square
            err = 1;
            seq = [];
        end
    else
        % Must have arguments to proceed
        err = 1;
        seq = [];
    end
    
end

