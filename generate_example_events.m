function event_times = generate_example_events(n_days, event_rate, center_time)
% function generate_example_events(n_days, event_rate)

if nargin < 1
    n_days = 30;
end

if nargin < 2
    event_rate  = 100;
end

if nargin < 3
    center_time = 17;
end

% How many events in total
n_events        = n_days * event_rate;

event_times     = [];
for a = 1:n_days
    events_numeric  = randn(event_rate, 1);
    events_24h      = events_numeric * 24 + center_time;
    events_hours    = hours(events_24h);


    events_24h      = events_numeric * 6 + center_time;
    events_hours    = hours(events_24h);

    % Convert duration in hours into datetime by adding dummy date (today)
    day_event_times     = dateshift(datetime('now'),'start','day') + events_hours';
    
    event_times     = [event_times; day_event_times(:) + days(a)];
end

