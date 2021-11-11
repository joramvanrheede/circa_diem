function [hist_handle] = circadian_histogram(event_times, time_res)
% function HIST_HANDLE = CIRCADIAN_HISTOGRAM(EVENT_TIMES, TIME_RES)
% 
% Plot a circular histogram of events in time bins around the 24 clock.
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
% HIST_HANDLE: Handle to the circadian histogram figure.
% 
% 
% Circa Diem Toolbox 2021

% Default to 1 hour time bins
if nargin < 2
    time_res = 1;
end

% Get histogram counts
[counts, time_edges] = circadian_hist_counts(event_times, time_res);

% Convert edge times to angles
edge_angles     = datetimes_to_angles(time_edges);

% get mean or median of all in_values at each 1h point
hist_handle   	= polarhistogram('BinEdges',edge_angles, 'BinCounts',counts,'LineWidth',2);

% Function that adjusts the labels & aesthetics on circadian plots
circadian_plot_aesthetics
