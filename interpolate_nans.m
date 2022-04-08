function new_signal = interpolate_nans(x_vals,signal,extrapolate)
% function new_signal = interpolate_nans(signal,extrapolate)

if nargin < 2
    extrapolate = 0;
end

new_signal  = signal;

nan_inds        = find(isnan(signal));
non_nan_inds    = find(~isnan(signal));

for a = 1:length(nan_inds)
    this_ind    = nan_inds(a);
    below_ind   = non_nan_inds(find(non_nan_inds < this_ind,1,'last'));
    above_ind   = non_nan_inds(find(non_nan_inds > this_ind,1,'first'));
    
    if isempty(below_ind) && extrapolate
        new_signal(nan_inds(a)) = signal(above_ind);
    elseif isempty(above_ind) && extrapolate
        new_signal(nan_inds(a)) = signal(below_ind);
    else
        % Linear interpolation required
        start_x     = x_vals(below_ind);
        end_x       = x_vals(above_ind);
        target_x    = x_vals(this_ind);

        new_signal(this_ind) = interp1([start_x end_x],signal([below_ind above_ind]),target_x);
    end
    
end
