function [circadian_points, time_edges, plot_handle] = circadian_rose(time_points, in_data, time_res, stat, detrend)
% FUNCTION [CIRCADIAN_POINTS, TIME_EDGES, PLOT_HANDLE] = CIRCADIAN_ROSE(TIME_POINTS,IN_DATA, TIME_RES, STAT, DETREND)
% 
% Creates a circadian (0-24h) rose plot of the means of IN_DATA across
% the times of day contained in TIME_POINTS in the current axes, Petals 
% represent creating time bins of size TIME_RES (in hours). 
% 
% Each rose petal will have a height determined by the values of IN_DATA 
% with a time of day within its time bin. STAT determines whether petal 
% height will represent the mean or the median.
% 
% If DETREND is set to 'true'/1, the function will normalise the data by
% dividing the data points for each day by their median, removing
% influences from longer-term trends in the data.
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
% DETREND: true or false. If true, will remove variability between days by
% dividing each day by its mean or median value (mean or median determined
% by STAT).
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

% Default to no de-trending of data
if nargin < 5
    detrend = false;
end

% Default to using 'mean' rather than 'median'
if nargin < 4
    stat = 'mean';
end

% Default time resolution is 1 (hour)
if nargin < 3
    time_res = 1;
end

% Get means for circadian time points
[circadian_points, time_edges]  = circadian_means(time_points, in_data, time_res, stat, detrend);

% Make sure the vector is always in the same orientation
circadian_points        = circadian_points(:); 

% Convert 24h range to radians for polar representation
time_edges_radians      = ((0:time_res:24)/24) * 2 * pi;

% Each petal is a line that goes from edge 1 to edge 2 and then to 0
circadian_plot_times    = [time_edges_radians(1:end-1)' time_edges_radians(2:end)' zeros(size(circadian_points(:)))]';
circadian_plot_times    = [circadian_plot_times(:); circadian_plot_times(1)];

% Each value should be replicated for a line from edge 1 to edge 2, followed 
% by a zero for the line back to the origin / centre
circadian_plot_points   = [circadian_points(:) circadian_points(:) zeros(size(circadian_points(:)))]';
circadian_plot_points   = [circadian_plot_points(:); circadian_plot_points(1)];

% get mean or median of all in_values at each 1h point
plot_handle             = polarplot(circadian_plot_times(:),circadian_plot_points(:),'LineWidth',2);
set(gca,'ThetaZeroLocation','top','ThetaDir','clockwise')

% Plot aesthetics for polar axes
set(gca,'LineWidth',2,'FontSize',16,'FontName','Arial','FontWeight','Bold','TickDir','out','box','off','ThetaColor',[0 0 0],'RColor',[0 0 0],'GridColor',[0 0 0])

% Get the angles of the polar plot markers, convert to 24h clock values
angular_ticks           = get(gca,'ThetaTick');
circadian_ticks         = (angular_ticks / 360) * 24;

% Replace the numeric labels with time strings in the format 'hh:mm'
circadian_labels        = cell(size(circadian_ticks));
for i = 1:length(circadian_ticks)
    this_tick           = circadian_ticks(i);
    circadian_labels(i) = {[num2str(this_tick,'%02.f') ':00']};
end

% Change the labels to 24h notation
set(gca,'ThetaTickLabel', circadian_labels)

