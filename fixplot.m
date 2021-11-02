function fixplot(font_size,font_name)
% function FIXPLOT(FONT_SIZE, FONT_NAME)
% 
% Quick aesthetics fix for cartesian axes plots in MATLAB. Edit defaults to 
% your personal preferences.
% 
% OPTIONAL INPUTS:
% 
% FONT_SIZE: Sets axes ticks & labels font size (default is 14pt).
% 
% FONT_NAME: Sets axes ticks & labels font name (default is Helvetica).
% 
% Joram van Rheede, 2021

% Default to Arial
if nargin < 2
    font_name = 'Arial';
end

% Default to font size appropriate for single plots; smaller font size may
% be required if using many subplots
if nargin < 1 || isempty(font_size)
    font_size = 12;
end

% Edit plot settings to increase legibility and improve aesthetics
set(gca,'LineWidth',2,'FontSize',font_size,'FontName',font_name,'FontWeight','Bold','TickDir','out','box','off','XColor',[0 0 0],'YColor',[0 0 0])


