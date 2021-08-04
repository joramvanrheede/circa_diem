function circadian_plot_aesthetics

% Start from the top and go clockwise
set(gca,'ThetaZeroLocation','top','ThetaDir','clockwise')

% Plot aesthetics for polar axes
set(gca,'LineWidth',2,'FontSize',16,'FontName','Arial','FontWeight','Bold','TickDir','out','box','off','ThetaColor',[0 0 0],'RColor',[0 0 0],'GridColor',[0 0 0])

% Get the angles of the polar plot markers, convert to 24h clock values
angular_ticks           = get(gca,'ThetaTick');
circadian_ticks         = (angular_ticks / 360) * 24;

% Replace the numeric labels with time strings in the format 'hh:mm'
circadian_labels        = cell(size(circadian_ticks));
for i = 1:length(circadian_ticks)
    this_tick           = circadian_ticks(i);
    circadian_labels(i) = {[num2str(this_tick,'%02.f') ':00']};
end

% Change the labels to 24h notation
set(gca,'ThetaTickLabel', circadian_labels)