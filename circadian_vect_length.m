function [vector_length, vector_dir] = circadian_vect_length(circ_data_points, angles)

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

vector_length     	= circ_r(angles, final_circ_points);
vector_dir          = circ_mean(angles,final_circ_points);

