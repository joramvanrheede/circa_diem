function [shuffled_var_explained, p_val] = get_shuffled_var_explained(time_stamps, values, n_shuffles)
% function get_shuffled_var_explained(time_stamps, values)
% 
% Use shuffle to see if variance explained is significant
% 
% Joram van Rheede, 2021


% If no n_shuffles has been specified, default to 1000
if nargin < 3 || isempty(n_shuffles)
    n_shuffles = 1000;
end

% Default to complete shuffle rather than circshift
if nargin < 4
    shuffle_mode = 'circshift';
end


% pre-allocate the vector lengths and vector dirs for each shuffle
shuffled_var_explained     = NaN(n_shuffles, 1);
for a = 1:n_shuffles
    
    % Display update every 100 shuffles
    if mod(a,100) == 0
        disp([num2str(a) ' shuffles complete...'])
    end
    
    % Get shuffled data points
    shuffled_data_points    = within_day_shuffle(time_stamps, values, shuffle_mode);
    
    % Calculate resultant vector
    shuffled_var_explained(a) = variance_explained_by_timeofday(time_stamps, shuffled_data_points);
    
end

var_explained = variance_explained_by_timeofday(time_stamps, values);

% Get p-value of original vector compared to the distribution of shuffled 
% vectors:
p_val = sum(shuffled_var_explained > var_explained) / n_shuffles;