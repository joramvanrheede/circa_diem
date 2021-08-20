function [plot_handle] = plot_shuffled_vectors(shuffled_vector_lengths, shuffled_vector_dirs)
% [plot_handle] = plot_shuffled_vectors(shuffled_vector_lengths, shuffled_vector_dirs)
% 
% Plot shuffled circadian vectors
% 
% Joram van Rheede, 2021

% polar scatter plot
plot_handle = polarscatter(shuffled_vector_dirs, shuffled_vector_lengths,'ko','filled','MarkerFaceAlpha',.1, 'MarkerEdgeAlpha',.2);

% Function with formatting defaults for circadian polar plots
circadian_plot_aesthetics