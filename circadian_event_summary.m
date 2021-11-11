function circadian_event_summary(event_times)
% function CIRCADIAN_EVENT_SUMMARY(EVENT_TIMES)
% 
% Generates a circadian summary figure for a data set consisting of
% EVENT_TIMES specified as a vector of datetimes, with the following
% panels:
% 
% 1. Top row: A histogram of the event times across the data collection
% time.
% 
% 2. Bottom left - A circadian matrix - the event times histogram counts
% represented as a heatmap of n_days * n_times.
%
% 3. Bottom centre - A circadian histogram showing event counts around the
% 24h circadian cycle.
%
% 4. Bottom right - the circadian resultant vector plus a point cloud of
% vectors generated from random event times.
% 
% INPUT:
% 
% EVENT_TIMES: A vector of datetimes specifying the event times.
% 
% Circa Diem Toolbox 2021

% Initialise figure
figure
set(gcf,'Units','normalized','Position',[.1 .2 .8 .6])

%% Preprocessing:

% Sort event times and values for plotting purposes
[event_times]    = sort(event_times);


%% 1. Top row: running z-scored data (raw, not detrended)
subplot(2,1,1)

% Make sure event counting starts on the beginning of the first day and 
% ends on the end of the last day in the data set
start_time  = dateshift(min(event_times),'start','day');
end_time    = dateshift(max(event_times),'end','day');

% Set bin edges for the histogram over time
time_edges  = start_time:hours(1):end_time;

% Make histogram of event times
histogram(event_times, time_edges);

% Make axes tight around histogram bins
xlim([start_time, end_time])

% Add title
title('Histogram of events over time')

% Set y-axis label
ylabel('Event count')

% A bunch of standard plot aesthetics commands wrapped in a function:
fixplot


%% 2. Bottom row 1: circadian matrix
subplot(2,3,4)

% Make a circadian matrix, a summary of the data over time in which each
% row corresponds to a day and each column corresponds to a time of day bin
circadian_matrix = make_circadian_matrix(event_times, [], 1, 'median');

% Plot circadian matrix as a heatmap image
plot_circadian_matrix(circadian_matrix,2);


%% 3. Bottom row 2: Circadian rose plot
subplot(2,3,5)

% Circadian histogram: A representation of the data across the 24h cycle
circadian_histogram(event_times);


%% 4. Bottom row 3: Circadian vector + shuffled & p-value
subplot(2,3,6)

% Get the circadian resultant vector length and direction
[vector_length, vector_dir] = circadian_vect(event_times);

% Get 1000 randomised sets of events
random_times = get_random_times(start_time, end_time, length(event_times),1000);

% Get random vectors
[random_vect_lengths, random_vect_dirs] = circadian_vect(random_times);

% Calculate p-value with respect to random vector lengths
p_val = sum(random_vect_lengths >= vector_length) / length(random_times);

% Plot the shuffled vectors as a transparent scatter point cloud
plot_shuffled_vectors(random_vect_lengths, random_vect_dirs);

% Plot the actual vector on top as a line
hold on
plot_circadian_vector(vector_length, vector_dir)

title(['Randomised events p = ' num2str(p_val)]);


    
