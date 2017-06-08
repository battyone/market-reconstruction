% Reconstruction process main script

% Settings
showPlots = true;
alphabet = 3;
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

% Get the Markov matrix for the first half of coded data
probMtx = markovMatrix(firstHalf);

% Pre-allocate the memory for the plots
markovErrors = zeros(numSim, 1);
noMarkovErrors = zeros(numSim, 1);
xAxis = linspace(1, numSim, numSim);

for i=1:numSim

    % Generate the sequence through a reconstruction process
    [ forecast, randForecast, f_err ] = procRcnst(probMtx, secondHalf, alphabet);

    % Calculate the error
    % Get the error count
    procError = countError(secondHalf, forecast);
    % Get the count of right guesses
    idxRight = find( procError(:,1) == 0 );
    rightCount = procError(idxRight, 2);
    totalCount = sum( procError(:,2) );
    % The error using the reconstruction process is
    markovError = 1 - (rightCount ./ totalCount);
    % Add to the plot
    markovErrors(i) = markovError;

    % Compare the result with total random values
    K = length(secondHalf);
    alpha = max( unique(secondHalf) );
    % Generate a totally random forecast
    % randForecast = getRandomVector(alpha, K);
    randError = countError(secondHalf, randForecast);
    % Get the count of right guesses
    idxRandRight = find( randError(:,1) == 0 );
    rightRandCount = randError(idxRandRight, 2);
    totalRandCount = sum( randError(:,2) );
    % The error using the reconstruction process is
    noMarkovError = 1 - (rightRandCount ./ totalRandCount);
    % Add to the plot
    noMarkovErrors(i) = noMarkovError;
    
end

% Display the results
if showPlots
    resMarkov = ['Using Markov, the mean error is ', num2str(mean(markovErrors))];
    disp(resMarkov);
    resRandom = ['With a random forecast, the mean error is ', num2str(mean(noMarkovErrors))];
    disp(resRandom);
    figure;
    plot(xAxis,markovErrors,'-',xAxis,noMarkovErrors,'-');
    xlabel('Simulation number');
    ylabel('Relative Error');
    title('Errors on a Markov and a random forecast');
    axis([1 numSim 0 1]);
    legend('Markov', 'Random');
end