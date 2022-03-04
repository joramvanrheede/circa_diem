![Greenwich 24h clock embossed with circa diem rose plot](https://github.com/joramvanrheede/circa_diem/blob/main/Greenwich_clock_embossed_with_blue_Beta.png?raw=true)

# Circa Diem toolbox

Matlab toolbox for plotting and analysis of diurnal patterns in data.
 
The Circa Diem toolbox is designed to generate diurnal visualisations and analyses of data points with associated MATLAB 'datetime' values. The basic input data format for the toolbox can be either:

1) a _**regularly spaced**_ series of time points as a vector of MATLAB 'datetimes' that correspond to events or measurement times, and a series of values or weights corresponding to these measurement times or events. Here the focus is on whether the measured variable has diurnal properties.

2) A series of event times. Here, the focus is on whether the event times are differently distributed across the times of day.

Circa Diem also allows for some statistical tests of the extent of non-uniformity of diurnal patterns. For this, the toolbox is indebted to the [circstat_matlab](https://github.com/circstat/circstat-matlab) toolbox by Philipp Berens (some of the statistical functions are essentially wrapper functions around circstat functions).

## Contents

### Preprocessing

`detrend_circadian_data`: Remove trends across multiple days by normalising values for each day to their mean or median.


### Statistics

`circadian_means`: Get mean or median values of circadian data in time bins around the 24h circadian cycle.

`circadian_hist_counts`: Count events in time bins around the 24 circadian cycle.

`make_circadian_matrix`: Represent a variable collected at a series of time points as a matrix with each row representing a day, and each column representing a time bin (in hours). Each point in the matrix will be the mean/median of values in this bin. For events-only data, the entries in the matrix instead represent event counts within each time bin. Can be visualised as a heatmap with plot_circadian_matrix.

`circadian_rayleigh_test`: Performs a Rayleigh test on circadian data (uses [circstat](https://github.com/circstat/circstat-matlab)'s circ_rtest)

`circadian_vect`: Calculate the resultant vector length and direction of circadian data.

`circadian_periodogram`: Calculate the power spectral density of the fluctuations in the measured signal of interest on a timescale of hours.

`within_day_shuffle`: Shuffle data values within each day, either as a completely new random permutation or by applying a random circshift.

`get_shuffled_vectors`: Generate a distribution of circadian resultant vectors for shuffled data, and compare the actual resultant vector length with the distribution from the shuffled data to obtain a p-value that represents the probability of observing a circadian vector of this length in the shuffled distribution.


### Plotting

`circadian_summary_figure`: Generates a figure with the raw data series, a circadian matrix, a rose plot and a circadian resultant vector vs. a shuffled distribution.

`circadian_rose`: Rose plot of circadian data

`circadian_histogram`: Circular histogram of circadian data

`circadian_raster_plot`: Raster plot of events across multiple days, with a row for each day, and a line for each event

`plot_circadian_periodogram`: Plot the periodogram obtained from circadian_periodogram on a time scale appropriate for circadian studies. For data with real circadian variation, a clear peak at 24h is expected.

`plot_circadian_matrix`: Plot circadian data as a heatmap with a row for each day, using output from `make_circadian_matrix`

`plot_circadian_vector`: Plot the resultant vector of circadian data

`plot_shuffled_vectors`: Scatter plot of the resultant vectors 


### Utilities

`datetimes_to_angles`: Converts datetimes or durations to radian angles representing 24h between 0 and 2pi.

`angles_to_time_of_day`: Converts radian angles to duration values between 0 and 24h.

`circadian_plot_aesthetics`: Function to quickly turn MATLAB polar axes into an aesthetically pleasing representation of the 24h circadian cycle.

`subplot_equal_r`: Sets the radius ('r') of multiple polar axes in subplots to the same value.

`fixplot`: Function with a number of quick plot aesthetics fixes for plots in cartesian co-ordinates and/or image (e.g. heatmap) axes.


### Examples & Tutorial

**Work in progress...**

`Timeseries_tutorial_script`: A script that generates some example data and provides example code for using many of the toolbox's time-series-oriented functions.

`circadian_summary_figure`: Provides an example of how to use many of the regularly sampled data visualisations in the toolbox.

`circadian_event_figure`: Provides an example of how to use the event-based visualisations in the toolbox.


## Dependencies

This toolbox makes use of a number of the circular statistics functions in [circstat_matlab](https://github.com/circstat/circstat-matlab)


## Author
This toolbox was developed by:

Dr. Joram J. van Rheede

MRC Brain Network Dynamics Unit

University of Oxford, UK

*e-mail*: joram.vanrheede@bndu.ox.ac.uk
