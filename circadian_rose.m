function [circadian_points, time_edges, plot_handle] = circadian_rose(time_points, in_data, time_res, stat, colour)
% FUNCTION [CIRCADIAN_POINTS, TIME_EDGES, PLOT_HANDLE] = CIRCADIAN_ROSE(TIME_POINTS,IN_DATA, TIME_RES, STAT, COLOUR)
% 
% Creates a circadian (0-24h) rose plot of the means of IN_DATA across
% the times of day contained in TIME_POINTS in the current axes, Petals 
% represent creating time bins of size TIME_RES (in hours). 
% 
% Each rose petal will have a height determined by the values of IN_DATA 
% with a time of day within its time bin. STAT determines whether petal 
% height will represent the mean or the median.
% 
% 
% INPUTS:
%
% TIME_POINTS: Datetime vector of time points corresponding to data points
% in IN_DATA.
%
% IN_DATA: A vector of data values, with a corresponding value for each
% time point in TIME_POINTS. Use NaNs for missing data (they will be
% ignored).
%
% TIME_RES: The time resolution in hours, i.e. the size of the time bins 
% for creating the entries in the circadian matrix. Defaults to 1 (hour),
% dividing the day into 24 1-hour bins.
%
% STAT: Which statistic to use to generate each binned value. Default is 
% 'mean', but for a more robust estimate 'median' can be used.
% 
% COLOUR: Plot colour [R G B].
% 
% OUTPUTS:
% 
% CIRCADIAN_POINTS: An N_petals x 1 vector with the values for each of the 
% petals in the rose plot.
% 
% TIME_EDGES: A duration vector with the edges of the time bins ranging
% from 00:00 to 24:00, with bin width == TIME_RES.
% 
% PLOT_HANDLE: A handle to the circadian plot object.
%
% Joram van Rheede, May 2021

% Set defaults if needed

% Default to using 'mean' rather than 'median'
if nargin < 4
    stat = 'mean';
end

% Default time resolution is 1 (hour)
if nargin < 3
    time_res = 1;
end

% Get means for circadian time points
[circadian_points, time_edges]  = circadian_means(time_points, in_data, time_res, stat);

% Make sure the vector is in the correct orientation
circadian_points        = circadian_points(:); 

% Convert 24h range to radians for polar representation
time_edges_radians      = ((0:time_res:24)/24) * 2 * pi;


if nargin > 4
    % Try using polarhist 
    polarhistogram('BinEdges',time_edges_radians,'BinCounts',circadian_points,'FaceColor',colour)
else
    polarhistogram('BinEdges',time_edges_radians,'BinCounts',circadian_points)
end

% % Each petal is a line that goes from edge 1 to edge 2 and then to 0
% circadian_plot_times    = [time_edges_radians(1:end-1)' time_edges_radians(2:end)' zeros(size(circadian_points(:)))]';
% circadian_plot_times    = [circadian_plot_times(:); circadian_plot_times(1)];
% 
% % Each value should be replicated for a line from edge 1 to edge 2, followed 
% % by a zero for the line back to the origin / centre
% circadian_plot_points   = [circadian_points(:) circadian_points(:) zeros(size(circadian_points(:)))]';
% circadian_plot_points   = [circadian_plot_points(:); circadian_plot_points(1)];
% 
% % Use the polar plot function to plot the line
% if nargin > 4
%     % If colour is specified then use that
%     plot_handle             = polarplot(circadian_plot_times(:),circadian_plot_points(:),'LineWidth',2, 'Color', colour);
% else
%     % Otherwise don't specify and let MATLAB handle colour selection
%     plot_handle             = polarplot(circadian_plot_times(:),circadian_plot_points(:),'LineWidth',2);
% end

% Function that adjusts the labels & aesthetics on circadian plots
circadian_plot_aesthetics

