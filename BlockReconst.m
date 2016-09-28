% Reconstruction process main script

% Settings
showResult = true; % Display results in the console
alphabet = 5; % How many intervals to use for the coding alphabet
K = 3; % How long show the max k-markov chain be
numSim = 2; % How many simulations to run
logTheResults = false; % Should store the results in a text file
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

% Split the code into two roughly equal parts
n = length( code );
N = floor( n/2 );
firstHalf = code(1:N);
secondHalf = code(N+1:2*N);

% Pre-allocate the memory for the errors
errorsArr1 = cell(K-1, 1);
errorsArr2 = cell(K-1, 1);
errorsArr3 = cell(K-1, 1);

% Do the simulations for all Ks
for j=2:K

    % Pre-allocate the memory for the forecasts
    forecastArr = cell(numSim, 1);

    for i=1:numSim
        % Get the forecast for the second half of coded data
        display(['Calculating forescast ',num2str(i),' of ',num2str(numSim)]);
        [ forecastArr{i}, ~ ] = procBlockRcnst(firstHalf, secondHalf, K);
    end

    % Calculate the errors
    errorsArr1{j-1} = calcBlockErrors(forecastArr, secondHalf, 1);
    errorsArr2{j-1} = calcBlockErrors(forecastArr, secondHalf, 2);
    errorsArr3{j-1} = calcBlockErrors(forecastArr, secondHalf, 3);

    % Write the results to a text file in the specified sub-folder
    if logTheResults
        writeToFile(writeToFolder, forecastArr, firstHalf, secondHalf, alphabet, K);
    end
    
end

% Display the results
if showResult
    disp(errorsArr1);
    disp(errorsArr2);
    disp(errorsArr3);
end