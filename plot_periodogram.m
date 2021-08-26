function plot_periodogram(psd_estimate, time_periods, normalise, colour)
% function plot_periodogram(psd_estimate, time_periods, normalise)
% 
%

if nargin < 4
    colour = [0 0 0];
end

if normalise
    % Divide each column in psd_estimate by its mean
    psd_estimate = psd_estimate ./ mean(psd_estimate);
end

% Plot individual traces transparently
if ~isvector(psd_estimate)
    plot(time_periods, psd_estimate,'-','Color',[colour 0.25],'LineWidth',1)
    hold on
    % Plot mean trace
    plot(time_periods, mean(psd_estimate,2), '-', 'Color', colour, 'LineWidth', 3)
else
    plot(time_periods, psd_estimate, '-', 'Color', colour, 'LineWidth', 2)
end


% Plot labels
set(gca,'XTick',[0:6:96])
xlabel('Period in hours')
ylabel('Power spectral density')

% Aesthetics
fixplot
