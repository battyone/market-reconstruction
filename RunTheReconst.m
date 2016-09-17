% Reconstruction process main script

% Settings
showPlots = true;
alphabet = 3;

% Data File
data_file = 'Data/IBM.csv';

% Open the file
[ T0, P0, err ] = getPricesFromFile(data_file);

% Detred the data with a given polynomial degree
poly = 7;
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

% Generate the sequence through a reconstruction process
[ forecast, f_err ] = procRcnst(probMtx, secondHalf);

% Calculate the error
% Get the error count
procError = countError(secondHalf, forecast);
% Get the count of right guesses
idxRight = find( procError(:,1) == 0 );
rightCount = procError(idxRight, 2);
totalCount = sum( procError(:,2) );
% The error using the reconstruction process is
markovError = 1 - (rightCount ./ totalCount);

% Compare the result with total random values
K = length(secondHalf);
alpha = max( unique(secondHalf) );
% Generate a totally random forecast
randForecast = getRandomVector(alpha, K);
randError = countError(secondHalf, randForecast);
% Get the count of right guesses
idxRandRight = find( randError(:,1) == 0 );
rightRandCount = randError(idxRandRight, 2);
totalRandCount = sum( randError(:,2) );
% The error using the reconstruction process is
noMarkovError = 1 - (rightRandCount ./ totalRandCount);

% Display the results
if showPlots
    resMarkov = ['Using markov, the error is ', num2str(markovError)];
    disp(resMarkov);
    resRandom = ['With a random forecast, the error is ', num2str(noMarkovError)];
    disp(resRandom);
end