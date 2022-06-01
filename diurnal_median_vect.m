function [vector_length, vector_dir] = diurnal_median_vect(time_stamps, in_values, time_res)
% function [vector_length, vector_dir] = diurnal_median_vect(time_stamps, in_values, time_res)
% 
% Get a circadian vector based on the median values in time bins across
% days.
% 
% 

% Default to a time resolution of 1 hour
if nargin < 3
    time_res = 1;
end

% Get medians across days in bins
[time_bin_medians, bin_edges] = circadian_means(time_stamps, in_values, time_res, 'median');

% We need the center points of the bins rather than the edges, so that each
% value has one corresponding time point
bin_centers     = bin_edges(2:end) - 0.5*time_res;

% Now use the medians across days as input to the circadian_vect function
[vector_length, vector_dir] = circadian_vect(time_bin_medians, bin_centers);

