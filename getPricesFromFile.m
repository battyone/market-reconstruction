function [Time, Prices, Error] = getPricesFromFile(file_path)
% Extracts the information from data files retrieved from Yahoo! Finance

% Verify path validity
    if exist(file_path,'file')

        % Read the CSV file
        fid = fopen(file_path);
        values_matrix = textscan(fid,'%s%f%f%f%f%f%f','delimiter',',');
        fclose(fid);

        % Read the time vector
        Time = datenum(values_matrix{1});

        % Read the adjusted prices vector
        Prices = values_matrix{7};
        
        % No error found
        Error = 0;
        
    else
        
        % File reading error
        Time = [];
        Prices = [];
        Error = 1;

    end

end

