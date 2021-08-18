function [shuffled_vector_lengths, shuffled_vector_dirs, p_val] = plot_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode, detrend, stat)
% function plot_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode, detrend, stat)

% Get shuffled vectors
[shuffled_vector_lengths, shuffled_vector_dirs, p_val] = get_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode, detrend, stat);

% polar scatter plot
polarscatter(shuffled_vector_dirs, shuffled_vector_lengths,'ko','filled','MarkerFaceAlpha',.1, 'MarkerEdgeAlpha',.2)

% Function with formatting defaults for circadian polar plots
circadian_plot_aesthetics