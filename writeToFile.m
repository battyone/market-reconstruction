function [ err ] = writeToFile( writeToFolder, forecastArr, probArr, originalArr, alphabet, K )
% This function writes the cell arrays containing the simulations
% to a text file located in the defined folder

    if nargin == 4 || nargin == 6
        
        if nargin == 4
            alphabet = 'Unspecified';
            K = 'Unspecified';
        end

        if iscell(forecastArr) == 1
            % Get the size of the cell array
            s = size(forecastArr);
            N = s(1);

            % Set the time
            formatIn = 'dd/mm/yyyy HH:MM:SS';
            runTime = datestr(now, formatIn);
            formatOut = 'dd-mm-yyyy_HH-MM-SS';
            timestamp = datestr(now, formatOut);
            fileName = ['./' writeToFolder '/output_' timestamp '.txt'];
            
            % Output some information
            disp(['Writing the results to ' fileName]);
            
            % Open/Create the file
            fileID = fopen(fileName, 'w');
            
            % Write the headers
            fprintf(fileID, 'Simulation time: \t%s\n', runTime);
            fprintf(fileID, 'Alphabet size: \t\t%s\n', num2str(alphabet));
            fprintf(fileID, 'K-Chain size: \t\t%s\n', num2str(K));
            fprintf(fileID, 'Number of runs: \t%s\n\n', num2str(N));

            % Write the original data used to calculate the probabilities
            fprintf(fileID, 'Data used for the Markov probabilities\n\n');
            fprintf(fileID, '%d', probArr);
            
            % Write the original data used to forecast
            fprintf(fileID, '\n\nData used for the forecast\n\n');
            fprintf(fileID, '%d', originalArr);
            
            fprintf(fileID, '\n\nForecasts obtained for the settings above\n\n');
            
            % Write the simulations
            for i=1:N
                fprintf(fileID, 'Run %d\n\n', i);
                fprintf(fileID, '%d', forecastArr{i});
                fprintf(fileID, '\n\n');
            end
            
            % Close the file
            fclose(fileID);
            
            % No error to output
            err = 0;
        else
            % Input is not a cell array
            err = 1;
        end
        
    else
        % Number of arguments is not enough
        err = 1;
    end

end

