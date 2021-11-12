function fit_obj = timeofday_fit(time_stamps, values, time_res)
% function FIT_OBJ = TIMEOFDAY_FIT(TIME_STAMPS, VALUES, TIME_RES)
% 
% Make a linear interpolated fit to generate an estimate for VALUES for
% any time of day based on the mean value for that time. The estimates are
% calculated for time bins of size by TIME_RES (in hours), and the overall
% fit is a linear interpolation between the bin means for the different bin
% centres.
% 
% INPUTS: 
% 
% TIME_STAMPS: A vector of datetimes corresponding to the times at which
% VALUES were measured.
% 
% VALUES: The measurement values corresponding to TIME_STAMPS.
% 
% TIME_RES: The size of the time bins in hours. /!\ For sensible results, 
% this value should be greater than the sampling interval of the data. /!\
% Defaults to 1.
% 
% OUTPUTS:
% 
% FIT_OBJ: A MATLAB fit object that can be used to retrieve values for any
% give time of day (specified numerically in hours).
% 
% 
% Circa Diem Toolbox 2021

% Default time resolution is half an hour
if nargin < 3
    time_res = 0.5;
end

% Get the means values in the time bins
[time_bin_means, bin_edges] = circadian_means(time_stamps, values, time_res);

% Convert numeric bin_edges to hours
bin_edges       = hours(bin_edges);

% Calculate the bin centres which are needed for the fit
bin_centres     = bin_edges - 0.5 * time_res;

% Add an extra bin centre such that the first bin centre extends below
% 00:00 and the final bin centre extends above 24:00 so that there are no
% out of range values
bin_centres     = [bin_centres(:); bin_centres(end) + time_res];

% add first value at the end and first value at the beginning so fit covers
% the whole 24h cycle 
time_bin_means  = [time_bin_means(end); time_bin_means(:); time_bin_means(1)];

% Fill empty values with neighbouring ones
if any(isnan(time_bin_means)) && ~all(isnan(time_bin_means))
    time_bin_means = interpolate_nans(bin_centres, time_bin_means, true);
end

% Produce fit_object
fit_obj         = fit(bin_centres, time_bin_means, 'linearinterp');

