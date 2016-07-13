% Reconstruction process main script

% Settings
showResult = true;
alphabet = 3;

% Data File
data_file = 'Data/IBM.csv';

% Open the file
[ T, P, err ] = getPricesFromFile(data_file);

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
% probMtx2 = markovMatrix(firstHalf);

% Get the Markov matrix for the first half of coded data
% using the K-block algorithm
probMtx = k_markov(firstHalf, 2);

acc_k_markov = get_acc_k_markov(probMtx);
% acc_markov = getAccMarkov(probMtx2);

% Display the results
if showResult
    % disp(acc_markov);
    disp(acc_k_markov);
end