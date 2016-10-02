% Settings
showPlots = true;

% Data File
data_file = 'Data/IBM.csv';

% Open the file and pre-process
[T, P, err] = getPricesFromFile(data_file);

% Get deltas
N = 10.^3;
Q = 8;
[d, n_delta, delta_err] = delta(T, P, N);
[S, n_S, moments_err] = moments_q(T, P, N, Q);
[chi, q, chi_err] = chiOfS(S, n_S);

% Plot the data
if err == 0 && showPlots
    % Plot the n-day returns
    if delta_err == 0
        figure;
        plot(n_delta,d);
        xlabel('n');
        ylabel('delta(n)');
        title('max_t {r(t,n)}');
    end
    
    % Plot the moments
    if moments_err == 0
        figure;
        hold on
        for j=1:Q
            % Do it in a logarithmic scale
            plot(log(n_S(:,j)),log(S(:,j)));
        end
        hold off
        xlabel('n');
        ylabel('S_q(n)');
        title('q-order moments of r(t,n)');
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
