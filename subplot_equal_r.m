function subplot_equal_r(r_val)
% FUNCTION SUBPLOT_EQUAL_R(R_VAL)
% 
% Sets all polar subplots to equal R-limits. If an R_VAL is specified, all
% polar subplots will range from [0 R_VAL].
% 
% If no input is given, all subplots will take the R-lims from the subplot 
% with the largest r-axis.
% 
% This function is chiefly intended for figures with only polar subplots.
% If other subplot types are present the function may throw an error.
% 
% Joram van Rheede - 2021

% Get axes objects from the different subplots
subplot_axes = get(gcf,'Children');

% If no R_VAL is specified, work out the maximum R_VAL from all axes
if nargin == 0
    % Initialise R_VAL variable
    r_val = 0;
    
    % Loop over axes
    for a = 1:length(subplot_axes)
        
        % Get size of R axis
        rlim    = get(subplot_axes(a),'RLim');
        
        % R_VAL is max of [(current R_VAL), (new RLim)]
        r_val   = max([r_val,rlim(2)]);
        
    end
end

% Set all axes RLims to [0 R_VAL]
for b = 1:length(subplot_axes)
    set(subplot_axes(b),'RLim',[0 r_val])
end