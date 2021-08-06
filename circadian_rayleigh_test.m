function [pval, z] = circadian_rayleigh_test(in_times, in_values)
% function [PVAL, Z] = CIRCADIAN_RAYLEIGH_TEST(IN_TIMES, IN_VALUES)
% 
% Computes the Rayleigh test for non-uniformity of circadian data using the 
% circstat toolbox ('circ_rtest').
% 
% INPUTS:
% 
% IN_TIMES: A vector of datetimes or durations specifying the times at
% which events or measurements occurred.
% 
% IN_VALUES (optional): A vector of values equal in size to IN_TIMES, 
% corresponding to the value / weight associated with each time point. If
% no IN_VALUES are specified, each time point has a default weight of 1.
% 
% 
% OUTPUTS:
% 
% PVAL: P-value representing the probability that the null hypothesis of
% values being evenly distributed around the circle is true. 
% 
% Z: Value of the Z-statistic from the Rayleigh test.
% 
% Joram van Rheede, 2021

% Convert input datetimes to angles (in radians)
time_angles         = datetimes_to_angles(in_times);

% If no values have been specified, give each angle a weight of 1
if nargin < 2
    in_values       = ones(size(time_angles));
end

% Vectorise circ_data_points and angles
in_values           = in_values(:);
time_angles      	= time_angles(:);

% Remove any NaN values
is_nan              = isnan(in_values);

if any(is_nan)
    in_values       = in_values(~is_nan);
    time_angles   	= time_angles(~is_nan);
end

% Perform Rayleigh test from circstat toolbox (see 'help circ_rtest' for 
% details)
[pval, z]           = circ_rtest(time_angles, in_values);
