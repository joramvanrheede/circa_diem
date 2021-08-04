function [time_bin_means, time_edges] = circadian_means(time_points, in_data, time_res, stat)
% function [bin_means, bin_edges] = circadian_means(time_points, in_data, time_res, stat)
% 
% Get mean values in time bins around the 24h circadian cycle
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
% STAT: Which statistic to use to generate each value. Default is  'mean', 
% but for a more robust estimate 'median' can be used.
% 
% 

if nargin < 5
    normalise = false;
end
if nargin < 4
    stat = 'mean';
end
if nargin < 3
    time_res = 1;
end

% get info about time of day
time_of_day         = timeofday(time_points);

% Create 'duration' variables for the time edges 
time_edges          = hours(0:time_res:24);

% Loop to determine the mean values of in_data for each time bin
n_bins              = length(time_edges) - 1;
time_bin_means      = NaN(n_bins,1);
for t_ind = 1:n_bins
        
        % Make boolean to select data from target time bin & combine with
        % day boolean
        q_timeofday = isbetween(time_of_day,time_edges(t_ind), time_edges(t_ind+1));
        
        % Get median of data in this time bin and add to matrix
        switch stat
            case 'mean'
                bin_mean    = nanmean(in_data(q_timeofday));
            case 'median'
                bin_mean    = nanmedian(in_data(q_timeofday));
        end
        
        time_bin_means(t_ind) = bin_mean;
end


