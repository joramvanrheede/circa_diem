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

my_favourite_colour     = [0.8500 0.3250 0.0980]; % change to your personal favourite

%% 0: Generate an example timeseries to work with

n_days          = 30; % Number of days to simulate
sample_freq     = 6; % Time resolution of sampling (samples/hour)
signal_perc     = 25; % Percentage of circadian signal (the rest is random noise)
smoothing       = 3; % Smoothing window for moving average smoothing (in samples)

[time_stamps, values]   = generate_example_timeseries(n_days, sample_freq, signal_perc, smoothing);


%% 2: Visualise the basic data set 

figure
set(gcf,'Units','Normalized','Position',[.2 .4 .6 .25])
plot_zscored_timeseries(time_stamps, values, my_favourite_colour)


%% 3: Visualise circadian periodicity in the data
figure
set(gcf,'Units','Normalized','Position',[.3 .3 .4 .3])

time_res        = 1; % time resolution (in hours) for periodogram
max_period      = 72; % Maximum period of 1 week = 168 hours
do_normalise    = true; % Whether to normalise the periodogram

% Calculate periodogram
[psd_estimate, time_periods] = circadian_periodogram(time_stamps, values, time_res, max_period);

% Plot the periodogram
plot_periodogram(psd_estimate, time_periods, do_normalise, my_favourite_colour)



%% 4: Calculate and visualise variance explained by time of day
% *Currently requires curve fitting toolbox

time_res        = 1;
n_shuffles      = 200;
shuffle_type    = 'circshift';

% Get the proportion of variance explained by time of day
var_explained = variance_explained_by_timeofday(time_stamps, values, time_res);

% Get the variance explained for shuffled data n_shuffles times to see whether var_explained is significant
[shuffled_var_explained, var_explained_p] = get_shuffled_var_explained(time_stamps, values, time_res, n_shuffles, shuffle_type);

% Plot a fit based on time of day to the data across days
figure
plot_timeofday_fit(time_stamps, values, time_res, my_favourite_colour)

% Add the variance explained by time of day & p-val to the figure title
title(['Var explained by TOD: ' num2str(var_explained) ', p =' num2str(var_explained_p)])

%% Alternative - polar plot

% Plot a fit based on time of day to the data across days
figure
plot_timeofday_fit(time_stamps, values, time_res, my_favourite_colour,'polar')


%% 5: Plot circadian rose plot
time_res    = 1;
stat        = 'mean';

figure
circadian_rose(time_stamps, values, time_res, stat, my_favourite_colour)


%% 6: Make heatmap of signal over time of day (rows) and 

time_res            = 1; % Temporal resolution of time bins (= heatmap pixels)
percentile_cutoff   = 2; % For the colour scale of the heatmap, ignore the top and bottom x% of data

[circadian_matrix, time_edges] = make_circadian_matrix(time_stamps, values, time_res);

figure
plot_circadian_matrix(circadian_matrix, percentile_cutoff, my_favourite_colour);

%% 7: Demo of circshift shuffle

% Get shuffled data points
shuffled_data_points    = within_day_shuffle(time_stamps, values, 'circshift');

[circadian_matrix, time_edges] = make_circadian_matrix(time_stamps, shuffled_data_points, time_res);
   

figure
plot_circadian_matrix(circadian_matrix, percentile_cutoff, my_favourite_colour);


%% 8: Calculate circadian vector
% *uses the circstat toolbox
n_shuffles  = 200;

[vector_length, vector_dir] = circadian_vect(time_stamps, values);

figure
plot_circadian_vector(vector_length, vector_dir, my_favourite_colour);


%% 9: Generate shuffled distribution, plot shuffled vectors

[shuffled_vector_lengths, shuffled_vector_dirs] = get_shuffled_vectors(time_stamps, values, n_shuffles);

hold on
plot_circadian_vector(shuffled_vector_lengths, shuffled_vector_dirs,[.5 .5 .5])

