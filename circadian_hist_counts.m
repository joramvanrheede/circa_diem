function [counts, time_edges] = circadian_hist_counts(event_times, time_res)
% function counts = circadian_hist_counts(event_times, time_res)
% 
% Count events in time bins around the 24 clock.
% 
% Joram van Rheede, 2021

% If durations are provided rather than datetimes, add dummy datetime so
% timeofday function can be usedc
if isduration(event_times)
    event_times = event_times + dateshift(datetime('now'),'start','day');
end

% get info about clock time and discard date info
time_of_day     = timeofday(event_times);

% Create 'duration' variables for the time edges
time_edges      = hours(0:time_res:24);

% Count the number of events in each time bin
counts          = histcounts(time_of_day,time_edges);