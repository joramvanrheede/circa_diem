function shaded_error_plot(x_vals, in_data, error_mode, shade_color, show_individual)
% function shaded_error_plot(x_vals, in_data, error_mode, shade_color, show_individual)
% Plots data as mean plus shaded error region
% 
% x_vals: x values for plot. if nargin < 2, xvals = 1:size(in_data,2)
% in_data: M*N data matrix, error and mean/median will be calculated across 
% first dimension and N should be equal to length(x_vals)
% error_mode: what error to display in shading: 'std' (default) for
% standard deviation, 'serr' for standard error, or 'iqr' for inter-
% quartile range. 'std'/'serr' modes will display a mean line, 'iqr' will 
% have a median line.
% shade_color: fill colour for error shading patch object
% show_individual: show individual data traces as well? (true/false)


%% Generate defaults
if nargin < 2
    in_data = x_vals;
    x_vals  = 1:size(in_data,2);
end
if nargin < 3
    error_mode = 'std';
end
if nargin < 4
    shade_color = [.6 .6 .6];
end
if nargin < 5
    show_individual = true;
end

%% 

data_mean           = nanmean(in_data);
data_std            = nanstd(in_data);
data_median         = nanmedian(in_data);
data_n              = sum(~isnan(in_data));

switch error_mode
    case 'std'
        high_vec            = data_mean + data_std;
        low_vec             = data_mean - data_std;
        mid_trace           = data_mean;
    case 'serr'
        data_serr           = data_std / sqrt(data_n);
        high_vec            = data_mean + data_serr;
        low_vec             = data_mean - data_serr;
        mid_trace           = data_mean;
    case 'iqr'
        high_vec            = prctile(in_data,75);
        low_vec             = prctile(in_data,25); 
        mid_trace           = data_median;
    case 'idr'
        high_vec            = prctile(in_data,90);
        low_vec             = prctile(in_data,10); 
        mid_trace           = data_median;
end

over_n_under_vec  	= [high_vec low_vec(end:-1:1)];
there_n_back_vec    = [x_vals x_vals(end:-1:1)];

if show_individual
    plot(x_vals, in_data,'LineWidth',0.5,'Color',[0 0 0 .2])
    hold on
end

fill(there_n_back_vec,over_n_under_vec,shade_color,'LineStyle','none','FaceAlpha',.6)
hold on

plot(x_vals, mid_trace,'k-','LineWidth',2)
hold off


