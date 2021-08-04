function [vector_lengths, vector_dirs] = get_shuffled_vectors(circ_data_points, n_shuffles, shuffle_mode)
% function [vector_lengths, vector_dirs] = get_shuffled_vectors(circ_data_points, n_shuffles)

% Default to complete
if nargin < 3
    shuffle_mode = 'complete';
end

vector_lengths  = NaN(n_shuffles, 1);
vector_dirs     = NaN(n_shuffles, 1);
for a = 1:n_shuffles
    switch shuffle_mode
        case 'complete'
            shuffled_data_points = shuffle_mat(circ_data_points,'rows');
        case 'circshift'
            shuffled_data_points = rand_circ_shift(circ_data_points,2);
    end
    [vector_lengths(a), vector_dirs(a)] = circadian_vect_length(shuffled_data_points);
    
end