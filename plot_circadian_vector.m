function plot_circadian_vector(event_times, event_values, vect_color)
% function plot_circadian_vector(event_times, event_values, vect_color)
% 
% Plot the resultant vector of circadian data
% 

if nargin < 3
    vect_color = [1 0 0];
end

% Get the length and direction of the average, normalised vector from the data
[vector_length, vector_dir] = circadian_vect(event_times, event_values);

% Make polar plot and plot vector as line from origin
polarplot([0 vector_dir],[0 vector_length],'-','LineWidth',3,'Color',vect_color)

% Add a dot at the end of the vector
hold on
polarplot(vector_dir, vector_length,'.','MarkerSize',25,'Color',vect_color)

% Function to make circadian polar plot look nice
circadian_plot_aesthetics


