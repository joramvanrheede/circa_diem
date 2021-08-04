function subplot_equal_r(r_val)
% function subplot_equal_r(r_val)
% Sets all polar subplots to equal r-limits
% Can be user-defined r-val, or if no input is given, all subplots will
% take the r-lims from the subplot with the largest r-axis
% 

subplot_axes = get(gcf,'Children');

if nargin == 0
    r_val = 0;
    
    for a = 1:length(subplot_axes)
        
        rlim    = get(subplot_axes(a),'RLim');
        r_val = max([r_val,rlim(2)]);
        if rlim(2) < r_val
            rlim(2) = r_val;
        else
            r_val = rlim(2);
        end
        
    end
end

for b = 1:length(subplot_axes)
    set(subplot_axes(b),'RLim',[0 r_val])
end