function [ error ] = calcBlockErrors( arrayOfRuns, origin, method )
% This function takes a Cell Array of different simulation runs
% and calculates the averaged error magnitude as e = <| ~a0 - a0 |>
% in relation to the original data series used in the forecast

    if nargin == 2
        % Default error counting method
        method = 1;
    end
    
    if iscell(arrayOfRuns) == 1
        % Get the length of the Cell Array
        s = size(arrayOfRuns);
        N = s(1);
        % Get the length of the origin
        s = size(origin);
        K = s(1);
        % Get the length of the elements being evaluated
        s = size(arrayOfRuns{1});
        Z = s(1);
        % Count the zeros in the vector
        initZeros = nnz(~arrayOfRuns{1});
        start = initZeros + 1;
        % Format the origin
        originData = origin(start:end);
        % Pre-allocate the size of the erro vector
        error = zeros(N, 1);
        
        % Process the arrays
        if K == Z
            for i=1:N
                % Get the forecast number i
                forecast = arrayOfRuns{i}(start:end);
                % Method 1: accumulate the absolute differences
                if method == 1
                    % Get the absolute of the different between the sets
                    diff = abs(originData - forecast);
                    % Sum all the differences
                    error(i, 1) = sum(diff);
                % Method 2: accumulate the binary differences
                elseif method == 2
                    % Get the absolute of the different between the sets
                    diff = abs(originData - forecast);
                    % Get the number of times an error occurred
                    error(i, 1) = nnz(diff);
                % Method 3: accumulate the square differences
                elseif method == 3
                    % Get the absolute of the different between the sets
                    diff = originData - forecast;
                    % Sum the square of all the differences
                    error(i, 1) = sum(diff.^2);
                end
            end
        else
            display('ERROR: The lengths of the origin and forecast do not match');
        end
    end

end
