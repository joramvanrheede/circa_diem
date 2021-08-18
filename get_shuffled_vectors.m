function [shuffled_vector_lengths, shuffled_vector_dirs, p_val] = get_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode, detrend, stat)
% function [vector_lengths, vector_dirs] = get_shuffled_vectors(time_points, in_data, n_shuffles, shuffle_mode, detrend, stat)
%

% Default to complete shuffle rather than circshift
if nargin < 4
    shuffle_mode = 'complete';
end

% Don't normalise within day by default
if nargin < 5
    detrend = false;
end

% Default to using 'mean' for normalising values within each day
if nargin < 6
    stat = 'mean';
end

% pre-allocate the vector lengths and vector dirs for each shuffle
shuffled_vector_lengths  = NaN(n_shuffles, 1);
shuffled_vector_dirs     = NaN(n_shuffles, 1);
for a = 1:n_shuffles
    
    if mod(a,100) == 0
        disp([num2str(a) ' shuffles complete...'])
    end
    
    % Get shuffled data points
    shuffled_data_points    = within_day_shuffle(time_points, in_data, shuffle_mode, detrend, stat);
    
    % Calculate resultant vector
    [shuffled_vector_lengths(a), shuffled_vector_dirs(a)] = circadian_vect(time_points,shuffled_data_points);
    
end

% Get vector length for original data
vector_length   = circadian_vect(time_points, in_data);

% Get p-value of original vector compared to the distribution of shuffled 
% vectors:
p_val = sum(shuffled_vector_lengths > vector_length) / n_shuffles;