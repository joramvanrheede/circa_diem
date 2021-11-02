function fit_obj = timeofday_fit(time_stamps, values, time_res)
% function fit_obj = timeofday_fit(time_stamps, values)
% 
% Produce a linear interpolated fit to generate an estimate for VALLES for
% any time of day.
% 
% Joram van Rheede, 2021

if nargin < 3
    time_res = 0.5;
end

[time_bin_means, bin_edges] = circadian_means(time_stamps, values, time_res);

bin_edges       = hours(bin_edges);
bin_centres     = bin_edges - 0.5 * time_res;

bin_centres     = [bin_centres(:); bin_centres(end) + time_res];

% add first value at the end and first value at the beginning so fit covers
% the whole 24h cycle (otherwise it would have to extrapolate for values
% between 00:00 - 00:30 and 23:30 - 24:00
time_bin_means  = [time_bin_means(end); time_bin_means(:); time_bin_means(1)];

% Fill empty values with neighbouring ones
if any(isnan(time_bin_means)) && ~all(isnan(time_bin_means))
    time_bin_means = interpolate_nans(bin_centres, time_bin_means, true);
end

% Produce fit_object
fit_obj         = fit(bin_centres, time_bin_means, 'linearinterp');

