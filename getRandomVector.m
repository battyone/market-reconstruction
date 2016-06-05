function [ output ] = getRandomVector( max, len )
% This function tries to retrieve a vector of length len
% filled with true random integers from 1 to max
% if it fails, use MATLAB's generator

% Get a vector of true random values from random.org
[ data, err ] = trueRand(len, 1, max);
% Or use MATLAB's pseudo-random generator, if quota exceeded
if err == 1
    output = rand(N,1);
    disp('Using pseudo-random numbers from MATLAB');
else
    output = data;
    disp('Using true random numbers from random.org');
end

end

