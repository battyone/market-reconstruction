% Settings
showPlots = true;

% Data File
data_file = 'Data/IBM.csv';

% Open the file and pre-process
[T, P, err] = getPricesFromFile(data_file);

% Rescaling
n = 3;
[ rs_time , rs_price , rs_err ] = preProcess( T , P , n );

% Get deltas
N = 10.^3;
Q = 8;
[d, n_delta, delta_err] = delta(rs_time, rs_price, N);
[S, n_S, moments_err] = moments_q(rs_time, rs_price, N, Q);
[chi, q, chi_err] = chiOfS(S, n_S);

% Plot the data
if err == 0 && showPlots
    % Plot the n-day returns
    if delta_err == 0
        figure;
        loglog(n_delta,d);
        xlabel('n');
        ylabel('delta(n)');
        title('max_t {r(t,n)}');
    end
    
    % Plot the moments
    if moments_err == 0
        figure;
        hold on;
        for j=1:Q
            % Do it in a logarithmic scale
            loglog(n_S(:,j),S(:,j));
        end
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        hold off
        xlabel('n');
        ylabel('S_q(n)');
        title('q-order moments of r(t,n)');
        legend('q=1','q=2','q=3','q=4','q=5','q=6','q=7','q=8','Location','southeast');
    end
    
    % Plot chi(q)
    if chi_err == 0
        figure;
        plot(q,chi,'x');
        xlabel('q');
        ylabel('chi(q)');
        title('scaling exponent');
    end
elseif err == 1
    % In case of error
    disp('There was a problem opening the file');
end
