function plot_timeofday_fit(time_stamps, values, time_res, colour, plot_type)
% function PLOT_TIMEOFDAY_FIT(TIME_STAMPS, VALUES, TIME_RES, COLOUR, PLOT_TYPE)
%
% Plot a fit across all data points aligned to time of day. 
%
% INPUTS:
% 
% TIME_STAMPS: Time points specified in matlab datetime format
% 
% VALUES: Values associated with the time points in TIME_STAMPS.
% 
% TIME_RES: The fit is determined by the means of the data in time bins
% across the 24h diurnal cycle. 
% 
% COLOUR: The colour for the plot ([R G B]). Defaults to black ([0 0 0]).
% 
% PLOT_TYPE: 'cartesian' for Cartesian xy axes, or 'polar' for a polar
% plot.
%
% 
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

% Default to cartesian 
if nargin < 5
    plot_type = 'cartesian';
end

% Plot the fit minute by minute
fit_times   = hours(0:(1/60):24);

fit_obj     = timeofday_fit(time_stamps, values, time_res);

timeofday_numeric   = hours(timeofday(time_stamps));

%fit_values          = fit_obj(timeofday_numeric);

switch plot_type
    case 'cartesian'
        scatter(timeofday(time_stamps),values,8,colour,'filled','MarkerFaceAlpha',0.3,'MarkerEdgeAlpha',0.3)
        hold on
        plot(fit_times,fit_obj(hours(fit_times)),'k-','LineWidth',2)
        xlim(hours([0 24]))
        fixplot(12)
        title('Time-of-day fit')
        ylabel('Value')
        xlabel('Time of day')
    case 'polar'
        polarscatter(datetimes_to_angles(time_stamps),values, [],colour,'o','filled','MarkerFaceAlpha',0.3,'MarkerEdgeAlpha',0.3)
        hold on
        polarplot(datetimes_to_angles(fit_times),fit_obj(hours(fit_times)),'k-','LineWidth',2)
        circadian_plot_aesthetics(12)
        title('Time-of-day fit')
end