% Reconstruction process main script

% Settings
showResult = true; % Display results in the console
alphabet = 5; % How many intervals to use for the coding alphabet
K = 8; % How long show the k-markov chain be
numSim = 2; % How many simulations to run
writeToFile = true; % Should store the results in a text file
writeToFolder = 'Results'; % Where to store the results

% Start the time counter
formatIn = 'dd/mm/yyyy HH:MM:SS';
startTime = datestr(now, formatIn);

% Data File
data_file = 'Data/IBM.csv';

% Open the file
[ T, P, ~ ] = getPricesFromFile(data_file);

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
    [ forecastArr{i}, ~ ] = procBlockRcnst(firstHalf, secondHalf, K);
end

% Stop the counter
stopTime = datestr(now, formatIn);

% Write the results to a text file in the specified sub-folder
if writeToFile
    formatOut = 'dd-mm-yyyy_HH-MM-SS';
    timestamp = datestr(now, formatOut);
    fileName = ['./' writeToFolder '/output_' timestamp '.txt'];
    disp(['Writing the results to ' fileName]);
    fileID = fopen(fileName, 'w');
    fprintf(fileID, 'Program started: \t%s\n', startTime);
    fprintf(fileID, 'Program stopped: \t%s\n', stopTime);
    fprintf(fileID, 'Alphabet of size: \t%s\n', num2str(alphabet));
    fprintf(fileID, 'K-Chain of size: \t%s\n', num2str(K));
    fprintf(fileID, 'Number of runs: \t%s\n\n', num2str(numSim));
    fprintf(fileID, 'Forecasts obtained for the settings above\n\n');
    for i=1:numSim
        fprintf(fileID, 'Run %d\n\n', i);
        fprintf(fileID, '%d', forecastArr{1});
        fprintf(fileID, '\n\n');
    end
    fclose(fileID);
end

% Display the results
if showResult
    % disp(acc_markov);
end