function plot_circadian_vector(event_times, event_values)
% function plot_circadian_vector(event_times, event_values)
% 
% Plot the resultant vector of circadian data
% 

% Get the length and direction of the average, normalised vector from the data
[vector_length, vector_dir] = circadian_vect(event_times, event_values);

% Make polar plot and plot vector as line from origin
polarplot([0 vector_dir],[0 vector_length],'-','LineWidth',4)

% Add a dot at the end of the vector
hold on
polarplot(vector_dir, vector_length,'.','MarkerSize',50)

% Function to make circadian polar plot look nice
circadian_plot_aesthetics


