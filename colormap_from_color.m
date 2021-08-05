function color_map = colormap_from_color(color,n_steps,base)
% FUNCTION COLOR_MAP = COLORMAP_FROM_COLOR(COLOR,N_STEPS,BASE)
% 
% Create colormap from input COLOR (specified as [R G B]). The colormap will 
% have N_STEPS levels (default is 128). Optional input argument BASE is the 
% color with which input COLOR is contrasted. Defaults to [0 0 0] i.e. black
% but white [1 1 1] or any other colour can also be used.
% 
% INPUTS:
% 
% COLOR: 3-element vector of [R G B] values that will represent the last 
% (i.e. 'maximum') value in the colormap
% 
% N_STEPS (optional): Number of increments in the color map, defaults to 128
%
% BASE (optional): 3-element vector of [R G B] values that represents the
% first (i.e. 'minimum') value in the colormap. Defaults to black [0 0 0]
% 
% OUTPUTS:
% 
% COLORMAP: an N_STEPS x 3 matrix of RGB values representing a colormap
% that transitions in N_STEPS linear steps from BASE to COLOR.
% 
% Joram van Rheede May 2021

% Default to a colormap with 128 levels
if nargin < 2
    n_steps = 128;
end

% If no reference color specified, default to black [0 0 0] 
if nargin < 3
	base    = [0 0 0];
end

% Create a linearly increasing vector of length N_steps between R, G and B
% values from the base color to the target color
R_vec   = linspace(base(1),color(1),n_steps);
G_vec   = linspace(base(2),color(2),n_steps);
B_vec   = linspace(base(3),color(3),n_steps);

% Concatenate all R, G and B values into the final colormap
color_map   = [R_vec(:) G_vec(:) B_vec(:)];