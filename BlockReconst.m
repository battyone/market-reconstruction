% Reconstruction process main script

% Settings
showResult = true;
alphabet = 5;
K = 8;

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

% Get the forcast for the second half of coded data
[ forecast, ~ ] = procBlockRcnst(firstHalf, secondHalf, K);

% Display the results
if showResult
    % disp(acc_markov);
end