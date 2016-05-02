% Reconstruction process main script

% Settings
showPlots = true;
alphabet = 3;

% Data File
data_file = 'Data/NYSE.csv';

% Open the file
[T, P, err] = getPricesFromFile(data_file);

% Get the 1-day returns
[ r_time , returns , r_err ] = nDayReturns( T , P );

% Get the code
[ code, c_err ] = codify( returns , alphabet );

% Get the Markov matrix
[ probMtx, N, m_err ] = markovMatrix(code);

% Generate the sequence
seq = procRcnst(probMtx, N);

% Find the error