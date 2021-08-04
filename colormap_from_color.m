function color_map = colormap_from_color(color,n_steps,base)
% function color_map = colormap_from_color(color,n_steps,base)
% 
% Create colormap from input COLOR. Colormap will have N_STEPS levels 
% (default is 128). Base represents the color with which input COLOR is
% contrasted. Defaults to [0 0 0] i.e. black, but white [1 1 1] or any
% other colour can also be used.
% 
% Joram van Rheede May 2021

if nargin < 2
    n_steps = 128;
end
if nargin < 3
	base    = [0 0 0];
end

R_vec   = linspace(base(1),color(1),n_steps);
G_vec   = linspace(base(2),color(2),n_steps);
B_vec   = linspace(base(3),color(3),n_steps);

color_map   = [R_vec(:) G_vec(:) B_vec(:)];