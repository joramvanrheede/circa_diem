function plot_periodogram(psd_estimate, time_periods, normalise, colour)
% function PLOT_PERIODOGRAM(PSD_ESTIMATE, TIME_PERIODS, NORMALISE, COLOUR)
% 
% Plot power spectral density across increasing time periods. PSD_ESTIMATE
% and TIME_PERIODS are obtained from circadian_periodogram.
% 
% 
% INPUTS:
% 
% PSD_ESTIMATE: Power spectral density estimate obtained from 
% circadian_periodogram. 
% 
% TIME_PERIODS: Time periods over which PSD_ESTIMATE has been calculated,
% obtained from circadian_periodogram.
% 
% NORMALISE (optional): Whether to normalise the periodogram to its mean 
% (useful when plotting several periodogram lines if they differ in scale).
% 
% COLOUR (optional): Specify a colour for the plot line(s). Default is
% black with black transparent individual lines.
% 
% 
% Joram van Rheede, 2021

% Default colour is black
if nargin < 4
    colour = [0 0 0];
end

% Default is to use no normalisation
if nargin < 3
    normalise   = false;
end

if normalise
    % Divide each column in psd_estimate by its mean
    psd_estimate = psd_estimate ./ mean(psd_estimate);
end

% Depending on whether input is a vector or matrix...
if ~isvector(psd_estimate)
    % Plot individual traces transparently
    plot(time_periods, psd_estimate,'-','Color',[colour 0.25],'LineWidth',1)
    hold on
    % Plot mean trace
    plot(time_periods, mean(psd_estimate,2), '-', 'Color', colour, 'LineWidth', 3)
else
    % Just a single line needs plotting
    plot(time_periods, psd_estimate, '-', 'Color', colour, 'LineWidth', 2)
end


% Plot labels
set(gca,'XTick',[0:6:max(time_periods)])
xlabel('Period in hours')
ylabel('Power spectral density')

% Aesthetics
fixplot
