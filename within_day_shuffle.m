function shuffled_data = within_day_shuffle(time_points, in_data, shuffle_mode, detrend, stat)
% function within_day_shuffle(time_stamps, values, shuffle_mode, detrend, stat)
% 


% Default is to use a total reshuffle rather than circshift
if nargin < 3
    shuffle_mode = 'shuffle';
end

% Default is not to normalise values for each day
if nargin < 4
    detrend = false;
end

% Default stat for normalising values for each day is 'mean' 
if nargin < 5
    stat = 'mean';
end

% Set start time from 00:00 at start of first day to 24:00 at end of final
% day
start_time  = dateshift(time_points(1),'start','day');
end_time    = dateshift(time_points(end),'end','day');

% Check number of days between start and end time points
n_days    	= between(start_time, end_time, 'days'); 
n_days      = caldays(n_days);

% Pre-allocate shuffled data variable 
shuffled_data   = NaN(size(in_data));

% Loop over the number of days
for a = 1:n_days
    
    % Make boolean to select data from this day
    this_start  = start_time + caldays(a-1);
    this_end    = start_time + caldays(a);
    q_day       = isbetween(time_points, this_start, this_end);
    
    % Select data points from this day only
    day_data    = in_data(q_day);
    
    % If normalisation by day is requested,
    if detrend
        % depending on normalisation statistic ...
        switch stat
            case 'mean'
                % Divide data for this day by its mean
                day_data    = day_data / mean(day_data(:),'omitnan');
            case 'median'
                % Divide data for this day by its median
                day_data    = day_data / median(day_data(:),'omitnan');
        end
    end
    
    % How many data points are there for this day?
    n_points    = length(day_data);
    
    % Depending on shuffle mode:
    switch shuffle_mode
        case 'shuffle'
            % Get a random order of indices
            shuffle_inds            = randperm(n_points);
            
            % Place randomly shuffled data into preallocated variable
            shuffled_data(q_day)    = day_data(shuffle_inds);
            
        case 'circshift'
            % Do a random circshift of indices
            shift_inds              = circshift(1:n_points,randi(n_points));
            
            % Place randomly circshifted data into preallocated variable
            shuffled_data(q_day)    = day_data(shift_inds);
            
    end
end
