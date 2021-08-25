function plot_periodogram(psd_estimate, time_periods, normalise)
% function plot_periodogram(psd_estimate, time_periods, normalise)
% 
%

if normalise
    % Divide each column in psd_estimate by its mean
    psd_estimate = psd_estimate ./ mean(psd_estimate);
end

% Plot individual traces transparently
if ~isvector(psd_estimate)
    plot(time_periods, psd_estimate,'-','Color',[0 0 0 0.25],'LineWidth',1)
    hold on
end

% Plot mean trace
plot(time_periods, mean(psd_estimate,2), '-', 'Color', [0 0 0], 'LineWidth', 3)

% Plot labels
set(gca,'XTick',[0:6:96])
xlabel('Period in hours')
ylabel('Power spectral density')

% Aesthetics
fixplot
