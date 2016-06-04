function [ S, n, err ] = moments_q( T, P, N, Q )
% This function calculates the moments of q-order of |r(t,n)|
% such as S_q(n) = < |r(t,n)|^q >

    if nargin == 3
        % Default max of q moments
        Q = 8;
    end
    
    if N > length(P)
        S = [];
        n = [];
        err = 1;
    else
    
        % Calculate S_q(n)
        err = 0;
        S = zeros(N,Q);
        n = zeros(N,Q);

        for q=1:Q
            
            for i=1:N
                
                [~, R, err] = nDayReturns(T, P, i);
                
                S(i,q) = mean(abs(R).^q);
                n(i,q) = i;
                
            end

        end
        
    end
    
end

