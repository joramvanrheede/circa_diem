function time_of_day = angles_to_time_of_day(in_angles)
% function TIME_OF_DAY = ANGLES_TO_TIME_OF_DAY(IN_ANGLES)
% 
% Convert numeric radian angles into times of day (as Matlab durations).
% Angles above 2*pi re-start the count from 00:00. Example:
% 
% 0     --> 00:00
% .5pi  --> 06:00
% pi    --> 12:00
% 1.5pi --> 18:00
% 2pi   --> 00:00
% 3pi   --> 12:00
% 
% INPUTS:
% 
% IN_ANGLES: a vector or matrix of radian angles representing positions in
% the 24h cycle from 00:00 to 24:00.
% 
% OUTPUTS:
% 
% TIME_OF_DAY: a vector or matrix of size IN_ANGLES containing the time of
% day (as a Matlab duration) corresponding to IN_ANGLES.
%
% 
% Circa Diem toolbox 2021

% Divide by 2*pi to convert angles to proportions
angle_proportion    = in_angles / (2 * pi);

% Multiply proportion by number of hours in the day
clock_time_numeric  = angle_proportion * 24;

% Create a dummy datetime reference point starting today at 00:00
dummy_datetime      = dateshift(datetime('now'),'start','day');

% Add the number of hours from the angles to this dummy time
dummy_datetime    	= dummy_datetime + hours(clock_time_numeric);

% Get only the time of day component from this dummy time as a duration
time_of_day         = timeofday(dummy_datetime);