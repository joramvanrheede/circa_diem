function [var_explained, pre_var, post_var] = variance_explained_by_timeofday(time_stamps, values)
% function variance_explained_by_timeofday(time_stamps, values)
% 
% Calculate the amount of variance explained by time of day
% 
% Joram van Rheede, 2021

% Create linearly interpolated fit object to obtain a predicted value for
% each time of day
fit_obj                 = timeofday_fit(time_stamps, values);

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
