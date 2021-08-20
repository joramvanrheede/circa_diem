function random_times = get_random_times(start_time, end_time, n_events, n_repeats)
% function random_times = get_random_times(start_time, end_time, n_events, n_repeats)
% 
% Generate random times between a start and an end time.
% 
% Joram van Rheede, 2021

if nargin < 4
    n_repeats = 1;
end

% Generate a matrix of random numbers of the correct size
random_numbers  = rand(n_events, n_repeats);

% Get the total duration of time during which events should occur
total_time      = end_time - start_time;

% Multiply random numbers by the total time to get the random time
% intervals and add to start time to get datetimes in the required range
random_times    = start_time + random_numbers * total_time;
