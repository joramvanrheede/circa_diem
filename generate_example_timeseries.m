function [time_stamps, values] = generate_example_timeseries(n_days, sample_freq, signal_perc, smoothing)
% FUNCTION [TIME_STAMPS, VALUES] = GENERATE_EXAMPLE_TIMESERIES(N_DAYS, SAMPLE_FREQ, SIGNAL_PERC, SMOOTHING)
% 
% Basic simulation function to generate an example timeseries containing a 
% sinusoidal circadian component that peaks at noon within noise. Outputs 
% regularly spaced measurement TIME_STAMPS and associated simulated VALUES. 
% 
% By itself, GENERATE_EXAMPLE_TIMESERIES will generate 10 days worth of
% data sampled at 2 samples/hour with 20% sinusoidal signal within 80% 
% noise smoothed with a moving average window of 5 samples. These 
% properties can be controlled with the input variables below.
% 
% INPUTS:
% 
% N_DAYS: How many days of data to simulate? Defaults to 10.
% 
% SAMPLE_FREQ: Frequency at which the data are sampled. Defaults to 2
% samples / hour.
% 
% SIGNAL_PERC: Percentage of signal vs noise. Defaults to 20%.
% 
% SMOOTHING: Moving average window to smooth the data; this will
% effectively decrease the frequency of the random component in the data
% and introduce stronger correlations between successive time points.
% Defaults to 5.
% 
% 
% OUTPUTS:
% 
% TIME_STAMPS: The measurement times of the simulated data.
% 
% VALUES: The simulated measurement values associated with the TIME_STAMPS.
% 
% 
% Circa Diem Toolbox 2021

% Default smoothing to generate stronger local correlations between
% successive time points
if nargin < 4
    smoothing = 5;
end

% Signal percentage (within noise)
if nargin < 3
    signal_perc = 20;
end

% Frequency (in samples/hour)
if nargin < 2
    sample_freq = 2;
end

% Number of days for which to generate data
if nargin < 1
    n_days = 10;
end


% Work out number of samples across 24 hours
samples_per_day = sample_freq * 24;
n_samples       = samples_per_day * n_days;

% Get vector of increasing numbers up to total n_samples
sample_inds     = 1:n_samples;

sample_hour_num = sample_inds / n_samples * 24 * n_days;
sample_hours    = hours(sample_hour_num);

% Convert duration in hours into datetime by adding dummy date (today)
time_stamps     = dateshift(datetime('now'),'start','day') + sample_hours';

% Random values between 0 and 1
random_values   = rand([n_samples,1]);

% Sinusoid between 0 and 1, with offset to place peak at 12 noon
sine_xvals      = sample_inds / samples_per_day * 2 * pi;
sine_values     = 0.5 * sin(sine_xvals - 0.5*pi) + 1;

% Convert the percentage of signal to a proportion
signal_prop     = signal_perc / 100;

% Generate final signal from sine wave plus noise
values          = signal_prop * sine_values(:) + (1-signal_prop) * random_values(:);

% smooth signal
values          = smooth(values,smoothing);
