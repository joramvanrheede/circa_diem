function [var_explained, pre_var, post_var] = variance_explained_by_timeofday(time_stamps, values, time_res)
% function [VAR_EXPLAINED, PRE_VAR, POST_VAR] = VARIANCE_EXPLAINED_BY_TIMEOFDAY(TIME_STAMPS, VALUES, TIME_RES)
% 
% Calculate the proportion of variance explained by a fit to the data based
% on the means for particular times of day. The time-of-day fit is 
% calculated for time bins of size by TIME_RES (in hours), and the overall 
% fit is a linear interpolation between the bin means for the different bin 
% centres (see TIMEOFDAY_FIT).
% 
% INPUTS: 
% 
% TIME_STAMPS: A vector of datetimes corresponding to the times at which
% VALUES were measured.
% 
% VALUES: The measurement values corresponding to TIME_STAMPS.
% 
% TIME_RES: The size of the time bins in hours. /!\ For sensible results, 
% this value should be greater than the sampling interval of the data. /!\
% Defaults to 1.
% 
% OUTPUTS:
% 
% VAR_EXPLAINED: Proportion of variance explained.
% 
% PRE_VAR: Total variance in VALUES
% 
% POST_VAR: Variance after the estimates from the time of day fit have been
% subtracted.
% 
% 
% Circa Diem Toolbox 2021

% If not specified, let time_res default to 1 (hour)
if nargin < 3
    time_res = 1;
end

% Create linearly interpolated fit object to obtain a predicted value for
% each time of day
fit_obj                 = timeofday_fit(time_stamps, values, time_res);

% Convert datetimes to numeric time of day in hours (between 0 and 24)
time_stamps_numeric     = hours(timeofday(time_stamps));

% Use fit obj to fit the data
fit_to_data             = fit_obj(time_stamps_numeric);

% Subtract the fit from the data
fit_subtracted_data     = values - fit_to_data;

% Variance of input VALUES
pre_var                 = var(values);

% Variance after subtracting the fit to timeofday means
post_var                = var(fit_subtracted_data);

% Calculate proportion of variance explained
var_explained           = (pre_var - post_var) / pre_var;
