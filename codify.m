function [ output, err ] = codify( returns, alphabet )
%codify is the main function for the markov process
%   it is responsible for the creation of the returns' coding
    
    output = [];
    err = 1;
     
    if nargin == 1
        % Default number for the alphabet's symbols
        alphabet = 3;
    end
    
    if isfloat(returns)
        
        if alphabet > 2 && mod(alphabet,2) ~= 0
            
            % Determine how many intervals
            K = alphabet-2;
            
            err = 0;
            r_avg = mean(returns);
            r_std = std(returns);
            N = length(returns);
            % Detrended returns r(t)-<r(t)>
            dRtrn = returns - r_avg;
            output = zeros(N,1);
            test_low = r_avg - r_std;
            test_high = r_avg + r_std;

            for i=1:N
                code = 1;
                if dRtrn(i) < test_low
                    output(i) = code;
                elseif dRtrn(i) > test_high
                    output(i) = alphabet;
                else
                    for j=1:K
                        code = code + 1;
                        test = test_low + j * (2 * r_std / K);
                        if dRtrn(i) < test
                            output(i) = code;
                            break;
                        end
                    end
                end
            end
            
        end

    end
    
end

