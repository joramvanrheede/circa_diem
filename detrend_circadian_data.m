function detrended_values = detrend_circadian_data(time_points, values, stat)
% FUNCTION DETREND_CIRCADIAN_DATA(TIME_POINTS, VALUES, STAT)
% 
% Remove influence from long term trends in data to focus on circadian
% patterns by normalising data values for each day by their mean / median.
% STAT determines which of the two is used.
% 
% INPUTS:
%
% TIME_POINTS: Datetime vector of time points corresponding to data points
% in VALUES.
%
% VALUES: A vector of data values, with a corresponding value for each
% time point in TIME_POINTS. Use NaNs for missing data, they will be
% ignored.
%
% STAT: Which statistic to use to generate each binned value. Default is 
% 'mean', but for a more robust estimate 'median' can be used.
% 
% OUTPUT:
% 
% DETRENDED_VALUES: A vector of size(VALUES) in which data within each day
% have been normalised by dividing by that day's mean or median (as
% determined by STAT).
% 
% 
% Joram van Rheede, 2021

% If no stat is specified, default to 'mean'
if nargin < 3
    stat = 'mean';
end

% Set start time from 00:00 at start of first day to 24:00 at end of final
% day
start_time  = dateshift(min(time_points),'start','day');
end_time    = dateshift(max(time_points),'end','day');

% Check number of days between time points
n_days    	= between(start_time, end_time, 'days'); 
n_days      = caldays(n_days);

% Loop over the number of days
detrended_values  = NaN(size(values));
for a = 1:n_days
    
    % Make boolean to select data from this day
    this_start  = start_time + caldays(a-1);
    this_end    = start_time + caldays(a);
    q_day       = isbetween(time_points, this_start, this_end);
    
    % Depending on the requested summary statistic...
    switch stat
        case 'mean'
            % Divide values for this day by the mean for this day
            detrended_values(q_day) = values(q_day) / mean(values(q_day),'all','omitnan');
        case 'median'
            % Divide values for this day by the median for this day
            detrended_values(q_day) = values(q_day) / median(values(q_day),'all','omitnan');
    end
end
