function im_handle = plot_circadian_matrix(circadian_matrix, percentile_cutoff, colour)
% function IM_HANDLE = PLOT_CIRCADIAN_MATRIX(CIRCADIAN_MATRIX, PERCENTILE_CUTOFF, COLOUR)
% 
% Plot a circadian matrix of the type generated by MAKE_CIRCADIAN_MATRIX. 
% Has the option of cut off top and bottom percentiles from the colormap to 
% avoid effects of very small or large values on the overall colormap.
% 
% See help for MAKE_CIRCADIAN_MATRIX to get information on how the
% circadian matrix is generated.
% 
% INPUTS:
%
% CIRCADIAN_MATRIX: A circadian matrix obtained via 'MAKE_CIRCADIAN_MATRIX'
% 
% PERCENTILE_CUTOFF: A precentile to be cut off from the colormap on either
% side so avoid extreme values having too much influence on the color 
% scale.
% 
% 
% OUTPUTS:
% 
% IM_HANDLE: A handle to the image axes object.
% 
% 
% Circa Diem Toolbox, 2021

if nargin < 3 
    % Use whatever is default / current
    matrix_colour_map   = colormap;
else
    % Make colour map from speficied colour
    matrix_colour_map   = colormap_from_color(colour);
end

% By default, use the colormap scaling determined by the full range of the
% data
if nargin < 2 || isempty(percentile_cutoff)
    percentile_cutoff = 0;
end

% Plot circadian matrix as scaled colormapped image
im_handle = imagesc(circadian_matrix);

% If PERCENTILE_CUTOFF is specified, exclude top and bottom % from colour 
% range to keep the colormap informative despite extreme values in the data
set(gca,'CLim',prctile(circadian_matrix(:),[percentile_cutoff 100-percentile_cutoff]),'Colormap',matrix_colour_map)

% Add axis labels and set tick points
ylabel('Days')

% Divide day into 6-hour segments for X-axis labels
x_tick_inds = linspace(0,size(circadian_matrix,2),5);
xticks(x_tick_inds)
set(gca,'XTickLabels',{'00:00', '06:00', '12:00', '18:00', '24:00'})

% Cartesian plot aesthetics
fixplot
