function fixplot(font_size,font_name)
% function FIXPLOT
% 
% Quick aesthetics fix for cartesian axes plots in MATLAB. Edit defaults to 
% your personal preferences.
% 
% Joram van Rheede, 2021

% Default to Helvetica
if nargin < 2
    font_name = 'Helvetica';
end

% Default to font size appropriate for single plots; smaller font size may
% be required if using many subplots
if nargin < 1 || isempty(font_size)
    font_size = 14;
end

% Edit plot settings to increase legibility and improve aesthetics
set(gca,'LineWidth',2,'FontSize',font_size,'FontName',font_name,'FontWeight','Bold','TickDir','out','box','off')


