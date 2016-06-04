function [ delta, n, err ] = delta( T, P, N )
% This function finds the deltas (maximum of r(t,n) over t)
% such as delta(n) = max_t { r(t,n) }

    if N > length(P)
        delta = [];
        n = [];
        err = 1;
    else
    
        % Calculate delta
        err = 0;
        delta = zeros(N,1);
        n = zeros(N,1);

        for i=1:N

            [~, R, err] = nDayReturns(T, P, i);

            delta(i) = max(R);
            n(i) = i;

        end
        
    end
    
end

