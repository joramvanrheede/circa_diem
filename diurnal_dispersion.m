function dispersion = diurnal_dispersion(in_times)
% function dispersion = diurnal_dispersion(in_times)
% 
% Calculate circular dispersion around mean direction (std / mardia) from
% datetime values converted to angles representing times of day.
% 
% 


% Convert datetimes to angles corresponding to time of day:
time_angles = datetimes_to_angles(in_times);

% Calculate circular dispersion around mean direction
dispersion = circ_std(time_angles);
