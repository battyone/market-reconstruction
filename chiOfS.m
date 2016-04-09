function [ chi, q, err ] = chiOfS( S, n )
    
    if size(S) == size(n)
        
        log_S = log(S);
        log_n = log(n);
        
        N = size(S,2);
        chi = zeros(N,1);
        q = zeros(N,1);
        
        for i=1:N
            m = polyfit(log_n(:,i),log_S(:,i),1);
            chi(i) = m(1);
            q(i) = i;
        end
        
        err = 0;
        
    else
        chi = [];
        q = [];
        err = 1;
    end
        
end

