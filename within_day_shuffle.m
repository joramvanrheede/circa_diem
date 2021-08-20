function shuffled_data = within_day_shuffle(time_points, in_data, shuffle_mode)
% function shuffled_data = within_day_shuffle(time_points, in_data, shuffle_mode)
% 
% Shuffle values associated with data collection times within a day
% 


% Default is to use a complete reshuffle rather than circshift
if nargin < 3
    shuffle_mode = 'complete';
end

% Set start time from 00:00 at start of first day to 24:00 at end of final
% day
start_time  = dateshift(min(time_points),'start','day');
end_time    = dateshift(max(time_points),'end','day');

% Check number of days between start and end time points
n_days    	= between(start_time, end_time, 'days'); 
n_days      = caldays(n_days);

% Time points and values need to be sorted for circshift to work
[time_points, sort_inds] = sort(time_points);
in_data     = in_data(sort_inds);

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
    
    % How many data points are there for this day?
    n_points    = length(day_data);
    
    % Depending on shuffle mode:
    switch shuffle_mode
        case 'complete'
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
