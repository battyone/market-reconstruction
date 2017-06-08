% Settings
showPlots = true;
alphabet = 3;
montecarlo = true;
numSim = 500;

% Data File
data_file = 'Data/IBM.csv';

% Open the file
[ T0, P0, ~ ] = getPricesFromFile(data_file);

% Detred the data with a given polynomial degree
poly = 3;
[ T, P, err ] = preProcess(T0, P0, poly);

% Get the 1-day returns
[ r_time , returns , r_err ] = nDayReturns( T , P );

% Get the code
[ code, c_err ] = codify( returns , alphabet );

% Split the code in two roughly equal parts
n = length( code );
N = floor( n/2 );
firstHalf = code(1:N);
secondHalf = code(N+1:end);

% Get the price at time = n/2
init_p = P0(N);

% Get the time for the second half
T2 = T0(N+1:end-2);

% Get the Markov matrix for the first half of coded data
probMtx = markovMatrix(firstHalf);

if montecarlo
    Z = length(T2);
    % Pre-allocate the memory for the forecasts
    forecastArr = zeros(Z, numSim);
    randForecastArr = zeros(Z, numSim);
    predicted_r = zeros(Z, numSim);
    random_r = zeros(Z, numSim);
    predicted_p_all = zeros(Z, numSim);
    random_p_all = zeros(Z, numSim);
    predicted_p = zeros(Z, 1);
    random_p = zeros(Z, 1);
    for i=1:numSim
        [ forecastArr(:,i), randForecastArr(:,i), ~ ] = procRcnst(probMtx, secondHalf, alphabet);
        predicted_r(:,i) = uncodify(forecastArr(:,i), returns);
        random_r(:,i) = uncodify(randForecastArr(:,i), returns);
        predicted_p_all(:,i) = returnsToPrices(predicted_r(:,i), init_p);
        random_p_all(:,i) = returnsToPrices(random_r(:,i), init_p);
    end
    for j=1:Z
        predicted_p(j) = mean(predicted_p_all(j,:));
        random_p(j) = mean(random_p_all(j,:));
    end
else
    % Generate the sequence through a reconstruction process
    [ forecast, randForecast, ~ ] = procRcnst(probMtx, secondHalf, alphabet);

    % Get the uncodified returns
    predicted_r = uncodify(forecast, returns);
    random_r = uncodify(randForecast, returns);

    % Convert the returns back to prices
    predicted_p = returnsToPrices(predicted_r, init_p);
    random_p = returnsToPrices(random_r, init_p);
end

% Plot the historical price
if err == 0 && showPlots
    % Plot the prices
    figure;
    plot(T0,P0,T2,predicted_p,T2,random_p);
    datetick('x','keepticks','keeplimits');
    xlabel('Time');
    ylabel('Price (USD)');
    title('Historical Prices');
    legend('Real prices','Predicted prices','Random prices','Location','northwest');
elseif err == 1
    % In case of error
    disp('There was a problem opening the file');
end
