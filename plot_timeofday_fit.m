function plot_timeofday_fit(time_stamps, values, time_res, colour)
% function PLOT_TIMEOFDAY_FIT(TIME_STAMPS, VALUES, TIME_RES, COLOUR)
%
% Plot a time of day fit
% 
% Circa Diem Toolbox 2021


% Default to time bins of size of 1 hour for time of day fit
if nargin < 3 || isempty(time_res)
    time_res = 1;
end

% Default to black
if nargin < 4
    colour  = [0 0 0];
end

% Plot the fit minute by minute
fit_times   = hours(0:(1/60):24);

fit_obj     = timeofday_fit(time_stamps, values, time_res);

timeofday_numeric   = hours(timeofday(time_stamps));

%fit_values          = fit_obj(timeofday_numeric);

scatter(timeofday(time_stamps),values,8,colour,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
hold on
plot(fit_times,fit_obj(hours(fit_times)),'k-','LineWidth',2)
xlim(hours([0 24]))
fixplot(12)
title('Time-of-day fit')
ylabel('Value')
xlabel('Time of day')