function [vector_length, vector_dir] = circadian_vect(in_times, in_values)
% FUNCTION [VECTOR_LENGTH, VECTOR_DIR] = CIRCADIAN_VECT(IN_TIMES, IN_VALUES)
% 
% Calculates the resultant vector for data distributed around a circle
% representing the 24 hours of the day.
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

% Convert input datetimes to angles (in radians)
time_angles         = datetimes_to_angles(in_times);

% If no values have been specified, give each angle a weight of 1
if nargin < 2
    in_values       = ones(size(time_angles));
end

% Remove any NaN values
is_nan              = isnan(in_values);

% Set weight to 0
if any(is_nan)
    in_values(is_nan) = 0;
end

% Calculate length and direction of resultant vector using functions from
% circstat toolbox
vector_length     	= circ_r(time_angles, in_values);
vector_dir          = circ_mean(time_angles, in_values);

