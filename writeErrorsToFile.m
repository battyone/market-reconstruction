function [ err ] = writeErrorsToFile( writeToFolder, axis, errors, random )
% This function writes the results of the errors calculations
% to a text file located in the defined folder

    if nargin == 4

        % Set the time
        formatOut = 'dd-mm-yyyy_HH-MM-SS';
        timestamp = datestr(now, formatOut);
        fileName = ['./' writeToFolder '/errors_' timestamp '.txt'];

        % Output some information
        disp(['Writing the results to ' fileName]);

        % Open/Create the file
        fileID = fopen(fileName, 'w');

        % Write the headers
        fprintf(fileID, axis);
        fprintf(fileID, '\n');
        fprintf(fileID, errors);
        fprintf(fileID, '\n');
        fprintf(fileID, random);

        % Close the file
        fclose(fileID);

        % No error to output
        err = 0;

    else
        % Number of arguments is not enough
        err = 1;
    end

end

