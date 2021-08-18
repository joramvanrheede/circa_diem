function time_of_day = angles_to_time_of_day(in_angles)
% function TIME_OF_DAY = ANGLES_TO_TIME_OF_DAY(in_angles)

angle_proportion    = in_angles / (2 * pi);

clock_time_numeric  = angle_proportion * 24;

dummy_datetime      = dateshift(datetime('now'),'start','day');

dummy_datetime    	= dummy_datetime + hours(clock_time_numeric);

time_of_day         = timeofday(dummy_datetime);