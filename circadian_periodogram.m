function [psd_estimate, time_periods] = circadian_periodogram(time_stamps, signal, time_res, max_period)
% function [PSD_ESTIMATE, TARGET_FREQS] = CIRCADIAN_PERIODOGRAM(TIME_STAMPS, SIGNAL, TIME_RES, MAX_PERIOD)
% 
% Calculates a periodogram for timeseries SIGNAL collected at time points
% TIME_STAMPS, for periods increasing in steps of TIME_RES up to a maximum 
% period of MAX_PERIOD. 
% 
% The periodogram is essentially Welch's power spectral density estimate
% for the frequency that is the inverse of each time period. TIME_RES, 
% MAX_PERIOD, and output variable TIME_PERIODS are specified in units of 
% hours.
% 
% 
% INPUTS:
% 
% TIME_STAMPS: A vector of datetimes corresponding to the times at which
% SIGNAL was measured.
% 
% SIGNAL: The measurement values corresponding to TIME_STAMPS.
% 
% TIME_RES: The time resolution at which to calculate the periodogram in 
% hours. Defaults to 1 (hour).
% 
% MAX_PERIOD: The maximum time period for which to calculate the power
% spectral density.
% 
% OUTPUTS:
% 
% PSD_ESTIMATE: Power spectral density estimates obtained using Welch's 
% methods, for an increasing series of time periods.
% 
% TIME_PERIODS: The time periods for which PSD was calculated, in hours.
% 
% 
% Circa Diem Toolbox 2021

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

