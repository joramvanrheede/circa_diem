function plot_timeofday_fit(time_stamps, data_values, colour, time_res)
% function plot_timeofday_fit(time_stamps, data_values, colour)


fit_times   = hours(0:.5:24);

fit_obj     = timeofday_fit(time_stamps, data_values, time_res);
timeofday_numeric   = hours(timeofday(time_stamps));
%fit_values          = fit_obj(timeofday_numeric);

scatter(timeofday(time_stamps),data_values,8,colour,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5)
hold on
plot(fit_times,fit_obj(hours(fit_times)),'k-','LineWidth',2)
xlim(hours([0 24]))
fixplot(12)
title('Time-of-day fit')
ylabel('Value')
xlabel('Time of day')