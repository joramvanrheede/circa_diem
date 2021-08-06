function time_angles = datetimes_to_angles(in_time)
% FUNCTION TIME_ANGLES = DATETIMES_TO_ANGLES(IN_TIME)
% 
% Converts the time-of-day part of datetime array IN_TIME into radian
% angles between 0 and 2*pi.
% 
% In 24h notation, 00:00 -> 0, 12:00 -> pi, and 23:59:59.9999... -> 2*pi.
% 
% INPUTS:
% 
% IN_TIME: A vector or array of datetime values.
% 
% OUTPUTS:
% 
% TIME_ANGLES: A vector or array of size(IN_TIME), in which the time-of-day
% part of each entry in IN_TIME has been expressed as an angle in radians 
% between 0 and 2*pi.
% 
% Joram van Rheede, 2021

% Get hours, minutes and seconds from datetime input IN_TIME
[h, m, s]       = hms(in_time);

% Get time as a fraction of the day
time_fraction   = (h/24) + (m/24/60) + (s/24/60/60);

% Express the fractional time value as an angle between 0 and 2pi
time_angles     = time_fraction * 2*pi;