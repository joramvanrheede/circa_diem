function [shuffled_vector_lengths, shuffled_vector_dirs, p_val] = get_shuffled_median_vectors(time_points, in_data, n_shuffles, shuffle_mode, time_res)
% function [SHUFFLED_VECTOR_LENGTHS, SHUFFLED_VECTOR_DIRS, P_VAL] = get_shuffled_vectors(TIME_POINTS, IN_DATA, N_SHUFFLES, SHUFFLE_MODE)
% 
% Get the diurnal median vectors for shuffled data, and compare the
% actual vector length with the distribution from the shuffled
% data to obtain a p-value P_VAL that represents the probability of
% observing a circadian vector of this length in the shuffled distribution.
% 
% Returns SHUFFLED_VECTOR_LENGTHS and SHUFFLED_VECTOR_DIRS which together
% specify the resultant vectors for the shuffled data.
% 
% The number of shuffles is determined by N_SHUFFLES, and SHUFFLE_MODE
% provides the option of shuffling all data points within each day
% ('complete') or whether to apply a random circular shift to all values
% within each day ('circshift') so as to preserve any local correlations in
% the signal apart from those determined by time of day.
% 
% 
% INPUTS:
% 
% TIME_POINTS: A vector of datetimes or durations specifying the times at
% which events or measurements occurred.
% 
% IN_DATA: A vector of values equal in size to IN_TIMES, corresponding to 
% the value / weight associated with each time point.
% 
% N_SHUFFLES: How many times should the data be shuffled? Larger numbers of
% shuffles will result in a better approximation of the p-value but take
% longer. Defaults to 1000.
% 
% SHUFFLE_MODE: 'complete' for complete shuffle of all values within each
% day, or 'circshift' for 
% 
% 
% OUTPUTS:
% 
% SHUFFLED_VECTOR_LENGTHS: N_SHUFFLES x 1 vector with 1 circadian resultant
% vector length for each shuffled data set.
% 
% SHUFFLED_VECTOR_DIRS: N_SHUFFLES x 1 vector with 1 circadian resultant
% vector direction (as radian angle) for each shuffled data set.
% 
% P_VAL: p value of observing a circadian resultant vector of the same
% length as that obtained from the non-shuffled data set or greater in the 
% shuffled distribution.
% 
% 
% Joram van Rheede, 2021

% If no n_shuffles has been specified, default to 1000
if nargin < 3 || isempty(n_shuffles)
    n_shuffles = 1000;
end

% Default to complete shuffle rather than circshift
if nargin < 4
    shuffle_mode = 'complete';
end

if nargin < 5
    time_res = 1;
end

% pre-allocate the vector lengths and vector dirs for each shuffle
shuffled_vector_lengths  = NaN(n_shuffles, 1);
shuffled_vector_dirs     = NaN(n_shuffles, 1);
for a = 1:n_shuffles
    
    % Display update every 100 shuffles
    if mod(a,100) == 0
        disp([num2str(a) ' shuffles complete...'])
    end
    
    % Get shuffled data points
    shuffled_data_points    = within_day_shuffle(time_points, in_data, shuffle_mode);
    
    % Calculate resultant vector
    [shuffled_vector_lengths(a), shuffled_vector_dirs(a)] = diurnal_median_vect(time_points,shuffled_data_points, time_res);
    
end

% Get vector length for original data
vector_length   = diurnal_median_vect(time_points, in_data, time_res);

% Get p-value of original vector compared to the distribution of shuffled 
% vectors:
p_val = sum(shuffled_vector_lengths > vector_length) / n_shuffles;