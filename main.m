% Data File
data_file = 'Data/NYSE.csv';

% Open the file
[T, P, err] = getPricesFromFile(data_file);

% Get the nth polynomial fit for the data
n = 7;
[p, S, mu] = polyfit(T,P,n);
poly = polyval(p,T,S,mu);

% Detrending
dP = P - poly;

% Rescaling
[ rs_time , rs_price , rs_err ] = preProcess( T , P , n );

% Get the n-day returns
nday = 1;
[ nday_time , nday_return , nday_err ] = nDayReturns( T , P , nday );

% Get the historical volatility
ndays = 10;
[ vol_time , vol_hist , vol_err ] = histVol( nday_time , nday_return ,  ndays );

% Plot the historical price
if err == 0
    % Plot the prices
    figure;
    plot(T,P,T,poly);
    datetick('x','keepticks','keeplimits');
    xlabel('Time');
    ylabel('Price (USD)');
    title('Historical Prices');
    legend('Real prices','Polynomial fit (n=5)','Location','southeast');
    
    % Plot the detrending
    figure;
    plot(T,dP);
    datetick('x','keepticks','keeplimits');
    xlabel('Time');
    ylabel('Detrended Price (USD)');
    title('Historical Prices');
    
    %Plot the rescaling
    if rs_err == 0
        figure;
        plot(rs_time,rs_price);
        datetick('x','keepticks','keeplimits');
        xlabel('Time');
        ylabel('Detrended and Rescaled Price (USD)');
        title('Historical Prices');
    end
    
    % Plot the n-day returns
    if nday_err == 0
        figure;
        plot(nday_time,nday_return);
        datetick('x','keepticks','keeplimits');
        xlabel('Time');
        ylabel(strcat(num2str(nday),'-day returns'));
        title('Historical Returns');
    end
    
    % Plot the historical volatility
    if vol_err == 0
        figure;
        plot(vol_time,vol_hist);
        datetick('x','keepticks','keeplimits');
        xlabel('Time');
        ylabel(strcat(num2str(ndays),'-day volatility'));
        title('Historical Volatility');
    end
else
    % In case of error
    disp('There was a problem opening the file');
end
