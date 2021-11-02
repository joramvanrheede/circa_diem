function circadian_plot_aesthetics(font_size, font_name)
% FUNCTION CIRCADIAN_PLOT_AESTHETICS(FONT_SIZE, FONT_NAME)
% 
% Various typographic and graphical settings for circadian plots. Includes
% a number of tweaks to the standard polar axes, as well as a re-labeling
% of the angles between 0 and 2pi to 0h and 24h. Theta zero location
% (corresponding to 0h/24h) is set at the top of the axes, and the theta
% direction is set to go clockwise for a more intuitive interpretation in
% terms of the 24h clock.
% 
% OPTIONAL INPUTS:
% 
% FONT_SIZE: Sets axes ticks & labels font size (default is 14pt).
% 
% FONT_NAME: Sets axes ticks & labels font name (default is Helvetica).
% 
% 
% Joram van Rheede 2021

% Default to Arial
if nargin < 2
    font_name = 'Arial';
end

% Default to font size appropriate for single plots; smaller font size may
% be required if using many subplots
if nargin < 1 || isempty(font_size)
    font_size = 12;
end

% Start from the top and go clockwise
set(gca,'ThetaZeroLocation','top','ThetaDir','clockwise')

% Plot aesthetics for polar axes
set(gca,'LineWidth',2,'FontSize',font_size,'FontName',font_name,'FontWeight','Bold','TickDir','out','box','off','ThetaColor',[0 0 0],'RColor',[0 0 0],'GridColor',[0 0 0])

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