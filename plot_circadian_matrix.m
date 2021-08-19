function [circadian_matrix, time_edges] = plot_circadian_matrix(time_points, in_data, time_res, stat, detrend)
% function [circadian_matrix, time_edges] = plot_circadian_matrix(time_points, in_data, time_res, stat, detrend)
% 
% Plot IN_DATA collected at a series of TIME_POINTS (datetimes) as a 
% matrix with each row representing a day, and each column representing a 
% time bin (width of time_bin controlled by TIME_RES, in hours).
% 
% Each point in the matrix will be the average (mean or median, controlled
% by STAT) of all in_data points that were collected within that time bin.
% 
% INPUTS:
%
% TIME_POINTS: Datetime vector of time points corresponding to data points
% in IN_DATA.
%
% IN_DATA: A vector of data values, with a corresponding value for each
% time point in TIME_POINTS. Use NaNs for missing data, they will be
% ignored.
%
% TIME_RES: The time resolution in hours, i.e. the size of the time bins 
% for creating the entries in the circadian matrix. Defaults to 1 (hour),
% dividing the day into 24 1-hour bins.
%
% STAT: Which statistic to use to generate each binned value. Default is 
% 'mean', but for a more robust estimate 'median' can be used.
% 
% DETREND: Boolean - Remove long-term trends in the data by normalising 
% values to each day? Defaults to 'false'.
% 
% 
% OUTPUTS:
% 
% CIRCADIAN_MATRIX: An MxN matrix, where M is the number of days in
% time_points, and N is the number of time bins (as determined by
% TIME_RES).
% 
% TIME_EDGES: A duration vector of edges of the time bins around the 24h 
% clock, with the duration between successive edges equal to TIME_RES.
% 
% 
% 
% Joram van Rheede, 2021

if nargin < 3 || isempty(time_res)
    time_res = 1;
end

if nargin < 4 || isempty(stat)
    stat = 'mean';
end

if nargin < 5
    detrend = false;
end

% Make circadian matrix
[circadian_matrix, time_edges] = make_circadian_matrix(time_points, in_data, time_res, stat, detrend);

% Plot circadian matrix as scaled image
imagesc(circadian_matrix)

% Exclude top and bottom 2% from colour range to keep the colormap
% informative despite outliers in the data
set(gca,'CLim',prctile(circadian_matrix(:),[2 98]))

% Add axis labels and set tick points
ylabel('Days')

% Divide day into 6-hour segments for X-axis labels
x_tick_inds = linspace(0,size(circadian_matrix,2),5);
xticks(x_tick_inds)
set(gca,'XTickLabels',{'00:00', '06:00', '12:00', '18:00', '24:00'})

% Cartesian plot aesthetics
fixplot
