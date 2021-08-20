function circadian_raster_plot(event_times)
% function circadian_raster_plot(event_times)
% 
% Makes circadian raster plot of event_times, with a row for each day and a
% line between 0 and 24h for each event.
% 
% Joram van Rheede, 2021

% Default vertical spacing between raster plot lines
spacing     = 0.2;

% Set start time from 00:00 at start of first day to 24:00 at end of final
% day
start_time  = dateshift(min(event_times),'start','day');
end_time    = dateshift(max(event_times),'end','day');

% Check number of days between time points
n_days    	= between(start_time, end_time, 'days'); 
n_days      = caldays(n_days);

% For each row...
for a = 1:n_days
    
    % Make boolean to select data from this day
    this_start  = start_time + caldays(a-1);
    this_end    = start_time + caldays(a);
    q_day       = isbetween(event_times, this_start, this_end); 
    
    % get info about clock time and discard date info
    these_times_of_day  = hours(timeofday(event_times(q_day)));
    
    
    % turn into an N spikes * 1 vector
    xvals               = these_times_of_day(:);
    
    % Generate a vector of X values that goes like this:
    % [X1 X1 NaN X2 X2 NaN ... Xn Xn NaN]
    % Each set of X values is used to draw a vertical line (where the 
    % X-position does not vary, and the NaN is used to generate an empty
    % line segment so that the line for one spike is not connected to the 
    % next spike. This allows for using a single line object for each row
    % of spikes and is much faster and memory-efficient than generating
    % a line object for each individual spike.
    x_raster            = NaN(length(xvals)*3,1);
    x_raster(1:3:end)   = xvals;
    x_raster(2:3:end)   = xvals;
    
    % Generate a vector of Y values that goes like this:
    % [Y1a Y1b NaN Y2a Y2b NaN ... YNa YNb NaN]
    % Each set (YNa&b) specifies Y values for the top and bottom of the
    % line within the relevant row; interspersing with NaNs generates empty
    % line segment for efficiency reasons outlined above.
    y_raster            = NaN(length(xvals)*3,1);
    y_raster(1:3:end)   = a-spacing/2;
    y_raster(2:3:end)   = a-(1-spacing/2);
    
    % Plot all spikes in this row as a single line object with empty segments
    line_handles(a)     = line(x_raster(:),y_raster(:),'Color',[0 0 0]);
    
end

% x-axis aesthetics 
xlim([0 24])
xlabel('Time (h)')

set(gca,'XTick',[0 6 12 18 24])
set(gca,'XTickLabels',{'00:00' '06:00' '12:00' '18:00' '24:00'})

% Set y label
ylabel('Day #')

% Because your spikes are tight AF:
axis tight

% 'line' function by default seems to leave 'hold' set to 'on'
hold off

% Cartesian plot aesthetics
fixplot
% invert y axis so that figure can be read from top to bottom (i.e. top row
% is the first / most superficial channel, or the first trial / sweep)
axis ij
