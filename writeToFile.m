function [ err ] = writeToFile( writeToFolder, forecastArr, alphabet, K )
% This function writes the cell arrays containing the simulations
% to a text file located in the defined folder

    if nargin == 2 || nargin == 4
        
        if nargin == 2
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
            fprintf(fileID, 'Forecasts obtained for the settings above\n\n');
            
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

