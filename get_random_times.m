function random_times = get_random_times(start_time, end_time, n_events, n_repeats)
% FUNCTION RANDOM_TIMES = GET_RANDOM_TIMES(START_TIME, END_TIME, N_EVENTS, N_REPEATS)
% 
% Generate random event times between a start and an end time.
% 
% INPUTS:
% 
% START_TIME: Start time from which to generate events.
% 
% END_TIME: End time until which to generate events.
%
% N_EVENTS: How many events to generate between START_TIME and END_TIME.
%
% N_REPEATS: How many times to generate N_EVENTS random event times.
% 
% 
% OUTPUT:
% 
% RANDOM_TIMES: A matrix of datetimes of size N_EVENTS * N_REPEATS 
% containing random EVENT_TIMES between START_TIME and END_TIME.
% 
% 
% Circa Diem Toolbox, 2021

% By default, only generate random event times once
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
