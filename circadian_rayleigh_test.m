function [pval, z] = circadian_rayleigh_test(circ_data_points, angles)
% function [pval, z] = circadian_rayleigh_test(circ_data_points, angles)

n_angles    = size(circ_data_points,2);

% If no angles are specified
if nargin == 1
    % assume that circ_data_points are distributed over angles that evenly
    % span a circle
    angles = [1:n_angles]/n_angles*2*pi; 
end

% 
angles              = repmat(angles, size(circ_data_points,1),1);

% vectorise circ_data_points and angles
circ_data_points    = circ_data_points(:);
angles              = angles(:);

is_not_nan        	= ~isnan(circ_data_points);

final_circ_points   = circ_data_points(is_not_nan);
angles              = angles(is_not_nan);

[pval,z]            = circ_rtest(angles, final_circ_points);