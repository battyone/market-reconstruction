function [ error ] = calcBlockErrors( arrayOfRuns, origin )
% This function takes a Cell Array of different simulation runs
% and calculates the averaged error magnitude as e = <| ~a0 - a0 |>
% in relation to the original data series used in the forecast

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
        % Initial value and value in case of error
        error = 0;
        
        % Process the arrays
        if K == Z
            % Start an accumulator
            errAcc = zeros(N, 1);
            for i=1:N
                forecast = arrayOfRuns{i}(start:end);
                errAcc(i) = mean( abs(originData - forecast) );
            end
            error = mean( errAcc );
        else
            display('ERROR: The lengths of the origin and forecast do not match');
        end
    end

end
