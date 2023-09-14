function [shuffled_var_explained, p_val] = get_shuffled_var_explained(time_stamps, values, time_res, n_shuffles, shuffle_mode)
% function [shuffled_var_explained, p_val] = get_shuffled_var_explained(time_stamps, values, time_res, n_shuffles, shuffle_mode)
% 
% Use shuffle to see if variance explained is significant.
%
% INPUTS:
% 
% TIME_STAMPS
% 
% VALUES: Values associated with the time stamps
% 
% TIME_RES: Temporal resolution of the time-of-day fit
% 
% N_SHUFFLES: How many shuffles to perform for getting shuffled null
% distribution
% 
% SHUFFLE_MODE: 'circshift' or 'complete'. Circshift randomly shifts the
% data for a given day with a particular offset, 'complete' performs a
% shuffle of all values within a day for each day.
% 
% Circa Diem Toolbox 2021

% Default to time resolution of 1 hour
if nargin < 3 || isempty(time_res)
    time_res = 1;
end

% If no n_shuffles has been specified, default to 1000
if nargin < 4 || isempty(n_shuffles)
    n_shuffles = 1000;
end

% Default to circshift as more conservative than 
if nargin < 5
    shuffle_mode = 'circshift';
end

% pre-allocate the vector lengths and vector dirs for each shuffle
shuffled_var_explained     = NaN(n_shuffles, 1);
parfor a = 1:n_shuffles
    
    % Display update every 100 shuffles
    if mod(a,100) == 0
        disp([num2str(a) ' shuffles complete...'])
    end

    % Get shuffled data points
    shuffled_data_points    = within_day_shuffle(time_stamps, values, shuffle_mode);

    % Calculate resultant vector
    shuffled_var_explained(a) = variance_explained_by_timeofday(time_stamps, shuffled_data_points, time_res);
    
end

var_explained = variance_explained_by_timeofday(time_stamps, values);

% Get p-value of original vector compared to the distribution of shuffled 
% vectors:
p_val = sum(shuffled_var_explained > var_explained) / n_shuffles;