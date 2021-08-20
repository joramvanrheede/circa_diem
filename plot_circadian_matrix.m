function im_handle = plot_circadian_matrix(circadian_matrix, percentile_cutoff)
% function [circadian_matrix, time_edges] = plot_circadian_matrix(circadian_matrix)
% 
% Plot a circadian matrix generated with make_circadian_matrix. option to
% cut off top and bottom percentiles to avoid effect of very small or large
% values on the overall colormap.
% 
% Each point in the matrix will be the average (mean or median, controlled
% by STAT) of all in_data points that were collected within that time bin.
% 
% INPUTS:
%
% CIRCADIAN_MATRIX: A circadian matrix obtained via 'make_circadian_matrix'
% 
% 
% OUTPUTS:
% 
% IM_HANDLE: A handle to the image axes object.
% 
% 
% Joram van Rheede, 2021

if nargin < 2
    percentile_cutoff = 0;
end

% Plot circadian matrix as scaled image
im_handle = imagesc(circadian_matrix);

% Exclude top and bottom 2% from colour range to keep the colormap
% informative despite outliers in the data
set(gca,'CLim',prctile(circadian_matrix(:),[percentile_cutoff 100-percentile_cutoff]))

% Add axis labels and set tick points
ylabel('Days')

% Divide day into 6-hour segments for X-axis labels
x_tick_inds = linspace(0,size(circadian_matrix,2),5);
xticks(x_tick_inds)
set(gca,'XTickLabels',{'00:00', '06:00', '12:00', '18:00', '24:00'})

% Cartesian plot aesthetics
fixplot
