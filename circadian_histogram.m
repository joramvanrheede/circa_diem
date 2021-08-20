function [hist_handle] = circadian_histogram(event_times, time_res)
% function counts = circadian_hist_counts(event_times, time_res)
% 
% Plot a histogram of events in time bins around the 24 clock.
% 
% Joram van Rheede, 2021

% Get histogram counts
[counts, time_edges] = circadian_hist_counts(event_times, time_res);

% Convert edge times to angles
edge_angles     = datetimes_to_angles(time_edges);

% get mean or median of all in_values at each 1h point
hist_handle   	= polarhistogram('BinEdges',edge_angles, 'BinCounts',counts,'LineWidth',2);

% Function that adjusts the labels & aesthetics on circadian plots
circadian_plot_aesthetics
