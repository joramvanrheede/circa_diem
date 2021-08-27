function [hndl] = plot_circadian_vector(vector_length, vector_dir, vect_color)
% function plot_circadian_vector(vector_length, vector_dir, vect_color)
% 
% Plots the resultant vector for data distributed around a circle 
% representing the 24 hours of the day.
% 
% The VECTOR_LENGTH and VECTOR_DIR can be obtained from the function
% circadian_vect.
% 
% For details on the calculation of the resultant vector length and
% direction, see circstat functions circ_r and circ_mean.
% 
% INPUTS:
% 
% VECTOR_LENGTH: Length of circadian resultant vector (numeric). 
% 
% VECTOR_DIR: Direction of circadian vector (angle in radians).
% 
% OUTPUTS:
% 
% HNDL: A struct containing plot handles for the 'line' and 'marker'
% component of the polar plot.
% 
% 
% Joram van Rheede, 2021

if nargin < 3
    vect_color = [1 0 0];
end

for a = 1:length(vector_length)
    % Make polar plot and plot vector as line from origin
    hndl.line   = polarplot([0 vector_dir(a)],[0 vector_length(a)],'-','LineWidth',2,'Color',vect_color);
    
    % Add a dot at the end of the vector
    hold on
    hndl.marker = polarplot(vector_dir(a), vector_length(a),'.','MarkerSize',20,'Color',vect_color);
end

% Function to make circadian polar plot look nice
circadian_plot_aesthetics


