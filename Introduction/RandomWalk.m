% The market as a random walk

% Settings
N = 10000;
p_0 = 0;
prob_u = 0.5;
prob_d = 1 - prob_u;

% Initial conditions
S = zeros(N,1);
time = zeros(N,1);

for t=2:N
    % Throw a random number
    if rand > prob_u
        next_s = S(t-1) - 1;
    else
        next_s = S(t-1) + 1;
    end
    S(t) = next_s;
    time(t) = time(t-1) + 1;
end

figure;
plot(time,S);
xlabel('t');
ylabel('Price');
title('Random Walk');