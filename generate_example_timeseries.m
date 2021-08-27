function [time_stamps, values] = generate_example_timeseries(n_days, sample_freq, signal_perc, smoothing)
% function [time_stamps, values] = generate_example_timeseries(n_days, sample_freq, signal_perc, noise_perc)
% 
% 
% 

if nargin < 4
    smoothing = 5;
end

if nargin < 3
    signal_perc = 20;
end

if nargin < 2
    sample_freq = 2;
end

if nargin < 1
    n_days = 10;
end


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

% Sinusoid between 0 and 1
sine_xvals      = sample_inds / samples_per_day * 2 * pi;
sine_values     = 0.5 * sin(sine_xvals) + 1;


signal_prop     = signal_perc / 100;

% Generate final signal from sine wave plus noise
values          = signal_prop * sine_values(:) + (1-signal_prop) * random_values(:);

% smooth signal
values          = smooth(values,smoothing);