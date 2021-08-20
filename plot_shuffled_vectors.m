function [shuffled_vector_lengths, shuffled_vector_dirs, p_val] = plot_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode)
% function plot_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode)
% 
% Plot shuffled circadian vectors
% 
% Joram van Rheede, 2021

% Get shuffled vectors
[shuffled_vector_lengths, shuffled_vector_dirs, p_val] = get_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode);

% polar scatter plot
polarscatter(shuffled_vector_dirs, shuffled_vector_lengths,'ko','filled','MarkerFaceAlpha',.1, 'MarkerEdgeAlpha',.2)

% Function with formatting defaults for circadian polar plots
circadian_plot_aesthetics