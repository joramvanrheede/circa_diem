%% Circa Diem Toolbox - Timeseries tutorial
% 
% This tutorial walks you through how to use the Circa Diem toolbox for the
% visualisation and quantification of circadian trends in timeseries data.
% 
% Step 0 (Code cell 0) can be used to generate example data, or you can use
% 'time_stamps' (should be MATLAB datetimes) and 'values' from your own 
% data. See GENERATE_DATETIMES for easy conversion of numeric values to
% MATLAB datetimes.
%
% All subsequent code cells can be executed separately / in isolation and
% only depend on the existence of the variables 'time_stamps' and 'values'.
% 
% 
% 
% Circa Diem Toolbox 2021

%% 0: Generate an example timeseries to work with

n_days          = 30; % Number of days to simulate
sample_freq     = 6; % Time resolution of sampling (samples/hour)
signal_perc     = 25; % Percentage of circadian signal (the rest is random noise)
smoothing       = 3; % Smoothing window for moving average smoothing (in samples)

[time_stamps, values]   = generate_example_timeseries(n_days, sample_freq, signal_perc, smoothing);

%% 2: Visualise the basic data set 

figure
set(gcf,'Units','Normalized','Position',[.2 .4 .6 .25])
plot_zscored_timeseries(time_stamps, values)

%% 3: Visualise circadian periodicity in the data

time_res        = 1; % time resolution (in hours) for periodogram
max_period      = 72; % Maximum period of 1 week = 168 hours

% Calculate periodogram
[psd_estimate, time_periods] = circadian_periodogram(time_stamps, values, time_res, max_period);


do_normalise    = true;

% Plot the periodogram
figure
set(gcf,'Units','Normalized','Position',[.3 .4 .4 .2])
plot_periodogram(psd_estimate, time_periods, do_normalise)

%% 4: Calculate and visualise variance explained by time of day
% *Currently requires curve fitting toolbox

time_res    = 1;

variance_explained_by_timeofday(time_stamps, values, time_res)



