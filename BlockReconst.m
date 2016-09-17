% Reconstruction process main script

% Settings
showResult = true; % Display results in the console
alphabet = 5; % How many intervals to use for the coding alphabet
K = 8; % How long show the k-markov chain be
numSim = 2; % How many simulations to run
logTheResults = true; % Should store the results in a text file
writeToFolder = 'Results'; % Where to store the results

% Data File
data_file = 'Data/IBM.csv';

% Open the file
[ T0, P0, ~ ] = getPricesFromFile(data_file);

% Detred the data with a given polynomial degree
poly = 7;
[ T, P, ~ ] = preProcess(T0, P0, poly);

% Get the 1-day returns
[ r_time , returns , r_err ] = nDayReturns( T , P );

% Get the code
[ code, c_err ] = codify( returns , alphabet );

% Split the code in two roughly equal parts
n = length( code );
N = floor( n/2 );
firstHalf = code(1:N);
secondHalf = code(N+1:end);

% Pre-allocate the memory
forecastArr = cell(numSim, 1);

for i=1:numSim
    % Get the forecast for the second half of coded data
    display(['Calculating forescast ',num2str(i),' of ',num2str(numSim)]);
    [ forecastArr{i}, ~ ] = procBlockRcnst(firstHalf, secondHalf, K);
end

% Calculate the errors
error1 = calcBlockErrors(forecastArr, secondHalf, 1);
error2 = calcBlockErrors(forecastArr, secondHalf, 2);
error3 = calcBlockErrors(forecastArr, secondHalf, 3);

% Write the results to a text file in the specified sub-folder
if logTheResults
    writeToFile(writeToFolder, forecastArr, firstHalf, secondHalf, alphabet, K);
end

% Display the results
if showResult
    disp(error1);
    disp(error2);
    disp(error3);
end