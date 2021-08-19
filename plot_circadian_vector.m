function [vector_length, vector_dir] = plot_circadian_vector(event_times, event_values, vect_color)
% function plot_circadian_vector(event_times, event_values, vect_color)
% 
% Calculates and plots the resultant vector for data distributed around a 
% circle representing the 24 hours of the day.
% 
% Each data point contributes a vector angle (time of day) and, optionally, 
% a vector length (the value of the data timeseries associated with the 
% time of day). The resultant vector represents the average of all such 
% vectors.
% 
% The resultant vector's direction (VECTOR_DIR) indicates the direction 
% (time of day expressed as an angle between 0 and 2pi) towards which the 
% data are biased. The vector's length (VECTOR_LENGTH) indicates how great 
% the bias is. It ranges between 0 (the vectors completely cancel each 
% other out) and 1 (all IN_TIMES point in the same direction, or IN_VALUES 
% at all IN_TIMES except one are zero)
% 
% For details on the calculation of the resultant vector length and
% direction, see circstat functions circ_r and circ_mean.
% 
% INPUTS:
% 
% IN_TIMES: A vector of datetimes or durations specifying the times at
% which events or measurements occurred.
% 
% IN_VALUES (optional): A vector of values equal in size to IN_TIMES, 
% corresponding to the value / weight associated with each time point. If
% no IN_VALUES are specified, each time point has a default weight of 1.
% 
% 
% OUTPUTS:
% 
% VECTOR_LENGTH: The length of the resultant vector, a scalar between 0 and
% 1.
% 
% VECTOR_DIR: A scalar specifying the direction (angle) of the resultant
% vector (in radians).
% 
% 
% Joram van Rheede, 2021

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


