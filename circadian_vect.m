function [vector_length, vector_dir] = circadian_vect(circ_data_points, angles)
% FUNCTION [VECTOR_LENGTH, VECTOR_DIR] = circadian_vect(CIRC_DATA_POINTS, ANGLES)
% 
% 
% INPUTS:
% 
% CIRC_DATA_POINTS: an MxN matrix...
% 
% ANGLES:
% 
% OUTPUTS:
% 
% VECTOR_LENGTH:
% 
% VECTOR_DIR:
% 
% 
% Joram van Rheede - June 2021


% If no angles are specified, assume that circ_data_points are distributed 
% over angles that evenly span a circle
if nargin == 1
    % 
    n_angles    = size(circ_data_points,2);
    
    % generate n_angles evenly spaced angles between 0 and 2*pi
    angles  = [1:n_angles]/n_angles*2*pi; 
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

