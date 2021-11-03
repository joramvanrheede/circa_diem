function datetime_vals = generate_datetimes(time_in_hours, start_time)
% DATETIME_VALS = GENERATE_DATETIMES(TIME_IN_HOURS, START_TIME)
% 
% Turn numeric data collection time points (in hours) into MATLAB datetimes
% DATETIME_VALS used by the circa diem toolbox. 
%
% If no START_TIME is provided, DATETIME_VALS are generated as 
% TIME_IN_HOURS relative to a dummy start time of 00:00 of the current 
% date. If START_TIME is provided as a datetime, all DATETIME_VALS are 
% relative to that datetime. If START_TIME is provided as a duration or 
% numeric number of hours, DATETIME_VALS are generated relative to a dummy 
% start date of today, starting at START_TIME o'clock.
% 
% INPUTS:
% 
% TIME_IN_HOURS: The time points to be converted into datetimes, in units
% of hours. Can be numeric or specified as a MATLAB duration variable.
% 
% START_TIME (optional): The start time relative to which time_in_hours is
% measured. Defaults to the current date at 00:00 o'clock. If specified as
% a datetime, DATETIME_VALS are all relative to the specified date and
% time. If START_TIME is a number (between 0 and 24) or a duration 
% (between 0h and 24h), DATETIME_VALS are relative to today's date at 
% START_TIME o'clock.
% 
% OUTPUTS:
% 
% DATETIME_VALS: an output array of datetimes of size(TIME_IN_HOURS)
% containing TIME_IN_HOURS expressed as datetimes relative to a start time
% of START_TIME (or relative to 00:00 today if no start time is given).
% 
% 
% Circa Diem toolbox 2021



% Default to dummy start date of today at time 00:00
if nargin < 2
    start_time  = datetime('today');
elseif isnumeric(start_time)
    if start_time > 24
        warning('Numeric input START_TIME is greater than 24')
    end
    % If start time is given as a numeric number of hours, generate dummy 
    % start datetime of that time of day from today.
    start_time  = datetime('today') + hours(start_time);
elseif isduration(start_time)
    % If start time is given as a duration, generate dummy start datetime
    % of that time of day from today
    start_time  = datetime('today') + start_time;
end

% Convert numeric time in hours to a numeric 
if ~isduration(time_in_hours)
    time_in_hours  = hours(time_in_hours);
end

% Add the time in hours to the current datetimes to obtain datetime output
datetime_vals   = start_time + time_in_hours;

