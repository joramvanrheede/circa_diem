function [circadian_matrix, time_edges] = make_circadian_matrix(time_points, in_data, time_res, stat, detrend)
% function [CIRCADIAN_MATRIX, TIME_EDGES] = MAKE_CIRCADIAN_MATRIX(TIME_POINTS, IN_DATA, TIME_RES, STAT, DETREND)
%  
% Represent IN_DATA collected at a series of TIME_POINTS (datetimes) as a 
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
% OUTPUTS:
% 
% CIRCADIAN_MATRIX: An MxN matrix, where M is the number of days in
% time_points, and N is the number of time bins (as determined by
% TIME_RES).
% 
% TIME_EDGES: A duration vector of edges of the time bins around the 24h 
% clock, with the duration between successive edges equal to TIME_RES.
% 
% DETREND: Boolean - Remove long-term trends in the data by normalising 
% values to each day? Defaults to 'false'.
% 
% 
% Joram van Rheede, May 2021


if nargin < 3 || isempty(time_res)
    time_res = 1;
end

if nargin < 4 || isempty(stat)
    stat = 'mean';
end

if nargin < 5
    detrend = false;
end

if ~isvector(time_points)
    error('Input variable time_points should be a vector')
end

if ~isvector(in_data)
    error('Input variable in_data should be a vector')
end

% Set start time from 00:00 at start of first day to 24:00 at end of final
% day
start_time  = dateshift(time_points(1),'start','day');
end_time    = dateshift(time_points(end),'end','day');

% Check number of days between time points
n_days    	= between(start_time, end_time, 'days'); 
n_days      = caldays(n_days);

% Get vector with times of day regardless of date
time_points_timeofday   = timeofday(time_points);

% Determine time bin edges around the 24h clock in steps of time_res
time_edges              = hours(0:time_res:24);
n_bins                  = length(time_edges)-1;

% pre-allocate output variable
circadian_matrix        = NaN(n_days,n_bins);

% Loop over the number of days
for a = 1:n_days
    
    % Make boolean to select data from this day
    this_start  = start_time + caldays(a-1);
    this_end    = start_time + caldays(a);
    q_day       = isbetween(time_points, this_start, this_end);
    
    % Loop over the number of time bins
    for t_ind = 1:n_bins
        
        % Make boolean to select data from target time bin & combine with
        % day boolean
        q_timeofday = isbetween(time_points_timeofday,time_edges(t_ind), time_edges(t_ind+1));
        q_time_bin  = q_day & q_timeofday;
        
        % Get median of data in this time bin and add to matrix
        switch stat
            case 'mean'
                circadian_matrix(a,t_ind)  	= mean(in_data(q_time_bin),'omitnan');
            case 'median'
                circadian_matrix(a,t_ind)  	= median(in_data(q_time_bin),'omitnan');
        end
    end
end

% If detrending is requested...
if detrend
    % Depending on the measure of choice...
    switch stat
        case 'mean'
            % Divide each row (i.e. day) in the circadian matrix by its
            % mean
            circadian_matrix     = circadian_matrix ./ mean(circadian_matrix,2,'omitnan');
            
        case 'median'
            % Divide each row (i.e. day) in the circadian matrix by its
            % median
            circadian_matrix     = circadian_matrix ./ median(circadian_matrix,2,'omitnan');
end
