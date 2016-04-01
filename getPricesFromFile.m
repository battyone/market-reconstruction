function [Time, Prices, Error] = getPricesFromFile(file_path)
% Extracts the information from data retrived from Yahoo! Finance
    
% Verify path validity
    if exist(file_path,'file')

        % Read the CSV file
        fid = fopen(file_path);
        values_matrix = textscan(fid,'%f%f','delimiter',',');
        fclose(fid);

        % Read the time vector
        Time = values_matrix{1};

        % Read the adjusted prices vector
        Prices = values_matrix{2};
        
        % No error found
        Error = 0;
        
    else
        
        % File error
        Time = [];
        Prices = [];
        Error = 1;

    end

end

