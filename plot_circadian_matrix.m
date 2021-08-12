function [circadian_matrix, time_edges] = plot_circadian_matrix(time_points, in_data, time_res, stat, detrend)
% function [circadian_matrix, time_edges] = plot_circadian_matrix(time_points, in_data, time_res, stat, detrend)


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
circadian_matrix = make_circadian_matrix(time_points, in_data, time_res, stat, detrend);

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
