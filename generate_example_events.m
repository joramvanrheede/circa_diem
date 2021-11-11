function event_times = generate_example_events(n_days, event_rate, peak_time)
% function EVENT_TIMES = GENERATE_EXAMPLE_EVENTS(N_DAYS, EVENT_RATE, PEAK_TIME)
% 
% Basic simulation function to generate example event times with a
% frequency that varies sinusoidally across the course of the times of day.
% 
% By itself, GENERATE_EXAMPLE_EVENTS will generate 30 days worth of
% events, with an average of 100 events per day normally distributed around
% a peak at 12 noon.
% 
% INPUTS:
% 
% N_DAYS: How many days of data to simulate? Defaults to 30.
% 
% EVENT_RATE: How many events per day to generate? Defaults to 100.
% 
% PEAK_TIME: When in the day should events peak? Defaults to 12 noon. 
% 
% 
% OUTPUTS:
% 
% EVENT_TIMES: The simulated event times.
% 
% Circa Diem Toolbox 2021

if nargin < 1
    n_days = 30;
end

if nargin < 2
    event_rate  = 100;
end

if nargin < 3
    peak_time = 12;
end

event_times     = [];
for a = 1:n_days
    events_numeric  = randn(event_rate, 1);
    events_24h      = events_numeric * 24 + peak_time;
    events_hours    = hours(events_24h);


    events_24h      = events_numeric * 6 + peak_time;
    events_hours    = hours(events_24h);

    % Convert duration in hours into datetime by adding dummy date (today)
    day_event_times     = dateshift(datetime('now'),'start','day') + events_hours';
    
    event_times     = [event_times; day_event_times(:) + days(a)];
end

% Sort the event times so that they are sequential
event_times = sort(event_times);
