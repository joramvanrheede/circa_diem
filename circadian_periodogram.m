function [psd_estimate, time_periods] = circadian_periodogram(time_stamps, signal, time_res, max_period)
% function [psd_estimate, target_freqs] = circadian_periodogram(time_stamps, signal, time_res, max_period)
% 
% Calculates a circadian periodogram
% 
% 
% 

% Default to 1 hour time resolution
if nargin < 3 || isempty(time_res)
    time_res        = 1;
end

% Max period determined by total duration of data
if nargin < 4
    max_period      = floor(hours(max(time_stamps) - min(time_stamps)));
end

% Mean duration of sample interval
sample_interval     = median(diff(time_stamps));

% Get numeric number of days from duration variable
sample_interval     = hours(sample_interval);

% Convert to sample frequency
sample_freq         = 1/sample_interval;

% Start at 2*sample_interval or time_res, whichever is greater
min_period          = max([2*sample_interval, time_res]);

% Generate target frequencies based on time periods
time_periods        = min_period:time_res:max_period;
target_freqs        = 1./time_periods;

% Calculate periodogram with the welch method
psd_estimate        = pwelch(signal, [], [], target_freqs, sample_freq);

