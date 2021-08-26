function circadian_summary_figure(event_times, event_values)
% circadian_summary_figure(event_times, event_values)
% 
% Generates a summary figure for a circadian data set, with the following
% panels:
% 1. Top row: The raw z-scored data points
% 
% 2. Bottom left - A circadian matrix
%
% 3. Bottom centre - A circadian rose plot
%
% 4. Bottom right - the circadian resultant vector plus a point cloud of
% vectors
% 
% Joram van Rheede, 2021

% Initialise figure
figure
set(gcf,'Units','normalized','Position',[.1 .2 .8 .6])

%% Preprocessing:

% Sort event times and values for plotting purposes
[event_times, sort_inds]    = sort(event_times);
event_values                = event_values(sort_inds);

% Detrend the data by normalising each day's values to that day's median
detrended_values = detrend_circadian_data(event_times,event_values,'median');


%% 1. Top row: running z-scored data (raw, not detrended)
subplot(2,1,1)

plot_zscored_timeseries(event_times, event_values)

title('Z-scored data values over time')

%% 2. Bottom row 1: circadian matrix
subplot(2,3,4)

% Make a circadian matrix, a summary of the data over time in which each
% row corresponds to a day and each column corresponds to a time of day bin
circadian_matrix = make_circadian_matrix(event_times, detrended_values, 1, 'median');

% Plot circadian matrix as a heatmap image
plot_circadian_matrix(circadian_matrix,2);


%% 3. Bottom row 2: Circadian rose plot
subplot(2,3,5)

% Circadian rose plot: A representation of the data across the 24h cycle
circadian_rose(event_times, detrended_values, 1, 'median');


%% 4. Bottom row 3: Circadian vector + shuffled & p-value (rayleigh as well as shuffled p)
subplot(2,3,6)

% Get the circadian resultant vector length and direction
[vector_length, vector_dir] = circadian_vect(event_times, detrended_values);

% Get 1000 shuffled circadian vectors
[shuffled_vector_lengths, shuffled_vector_dirs, p_val] = get_shuffled_vectors(event_times, detrended_values, 1000, 'complete');

% Plot the shuffled vectors as a transparent scatter point cloud
plot_shuffled_vectors(shuffled_vector_lengths, shuffled_vector_dirs);

% Plot the actual vector on top as a line
hold on
plot_circadian_vector(vector_length, vector_dir)

title(['Circshift p = ' num2str(p_val)], 'Position',[180 0.8 0]);

    
