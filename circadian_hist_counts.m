function [event_counts, time_edges] = circadian_hist_counts(event_times, time_res)
% function [EVENT_COUNTS, TIME_EDGES] = CIRCADIAN_HIST_COUNTS(EVENT_TIMES, TIME_RES)
% 
% Count events in time bins spanning the 24 clock.
% 
% INPUTS:
% 
% EVENT_TIMES: Vector of datetimes specifying event times.
% 
% TIME_RES: Temporal resolution (i.e. bin size) in hours for the histogram 
% bins in which to count events. Defaults to 1 (hour).
% 
% OUTPUTS:
% 
% EVENT_COUNTS: The event counts in the time histogram bins.
% 
% TIME_EDGES: The edges of the histogram bins spanning the 24 hours of the
% day.
% 
% 
% Circa Diem Toolbox 2021

% Default to 1-hour bins
if nargin < 2
    time_res = 1;
end

% If durations are provided rather than datetimes, add dummy datetime so
% timeofday function can be used
if isduration(event_times)
    event_times = event_times + dateshift(datetime('now'),'start','day');
end

% Get info about clock time and discard date info
time_of_day     = timeofday(event_times);

% Create 'duration' variables for the time edges
time_edges      = hours(0:time_res:24);

% Count the number of events in each time bin
event_counts    = histcounts(time_of_day,time_edges);