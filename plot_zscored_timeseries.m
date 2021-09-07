function plot_zscored_timeseries(event_times, event_values, colour)
% function plot_zscored_timeseries(event_times, event_values, colour)
% 
% Plot z-scored EVENT_VALUES vs. EVENT_TIMES on the x-axis.
% 
% INPUTS:
% 
% EVENT_TIMES: Vector of datetimes corresponding to the times at which
% event_values were measured
% 
% EVENT_VALUES: Vector or matrix of values associated with EVENT_TIMES. If
% EVENT_VALUES is a vector, a single timeseries is plotted against
% EVENT_TIMES on the X-axis. If EVENT_VALUES is a matrix, its first
% dimension should be equal to length(EVENT_TIMES) and one timeseries per
% column is plotted.
% 
% COLOUR: Optional. Can specify the colour of the plot lines (single colour 
% only). Default is MATLAB's automatic colour assignment.
% 
% 
% Joram van Rheede, 2021


if nargin < 3
    % Plot zscored data using automatic MATLAB colour assignment
    scatter(event_times,zscore(event_values,0,'omitnan'),12,'filled');
else
    if length(colour) == 4
        alpha_val   = colour(4);
        colour      = colour(1:3);
    else
        alpha_val   = 1;
    end
        
    % Plot zscored data using colour specified by user
    scatter(event_times,zscore(event_values,0,'omitnan'),10,colour,'filled','MarkerFaceAlpha',alpha_val,'MarkerEdgeAlpha',alpha_val);
end

% Set xlims from start of first day to end of last day
start_time  = dateshift(min(event_times),'start','day');
end_time    = dateshift(max(event_times),'end','day');
xlim([start_time, end_time])

% Set y-axis label
ylabel('Z-score')

% A bunch of standard plot aesthetics commands wrapped in a function:
fixplot