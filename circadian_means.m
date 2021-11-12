function [time_bin_means, time_edges] = circadian_means(time_points, in_data, time_res, stat)
% function [time_bin_means, bin_edges] = circadian_means(time_points, in_data, time_res, stat)
%
% Get mean or median values for IN_DATA in time bins around the 24h 
% circadian cycle. TIME_POINTS specify the time points associated with the
% values in IN_DATA. TIME_RES controls the size of the time bins. STAT
% determines whether 'mean' or 'median' is reported. DETREND determines
% whether values for each day are normalised to specifically highlight 
% circadian variations. 
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
% OUTPUTS:
% 
% TIME_BIN_MEANS: Mean or median values for IN_DATA within the time bins
% as specified by TIME_BIN_EDGES
% 
% TIME_BIN_EDGES: The edges of the time bins used to generate the means, 
% determined by TIME_RES
%
% 
% Circa Diem Toolbox 2021

% Default to using mean if no statistic specified
if nargin < 4 || isempty(stat)
    stat = 'mean';
end

% Default to time resolution of 1 hour if none given
if nargin < 3 || isempty(time_res)
    time_res = 1;
end

% Get info about time of day
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
    
    % Get mean / median of data in this time bin
    switch stat
        case 'mean'
            time_bin_means(t_ind)    = mean(in_data(q_timeofday),'omitnan');
        case 'median'
            time_bin_means(t_ind)    = median(in_data(q_timeofday),'omitnan');
    end
end

