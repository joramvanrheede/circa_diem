# Circa Diem toolbox
Matlab toolbox for plotting and analysis of circadian patterns in data.
 
The Circa Diem toolbox is designed to generate circadian visualisations and analyses of data points with associated MATLAB 'datetime' values. The basic input data format for the toolbox is:

1) a series of time points as a vector of MATLAB 'datetimes' that correspond to events or measurement times, and 
2) a series of values or weights corresponding to these measurement times or events

Circa Diem also allows for some statistical tests of the extent of non-uniformity of circadian patterns. For this, the toolbox is heavily indebted to the [circstat_matlab](https://github.com/circstat/circstat-matlab) toolbox by Philipp Berens (some of the statistical functions are essentially wrapper functions around circstat functions).

## Contents

### Preprocessing

`detrend_circadian_data`: Remove trends across multiple days by normalising values for each day to their mean or median.


### Plotting

`circadian_summary_figure`: Generates a figure with the raw data series, a circadian matrix, a rose plot and a circadian resultant vector vs. a shuffled distribution.

`circadian_rose`: Rose plot of circadian data

`circadian_histogram`: Circular histogram of circadian data

`circadian_raster_plot`: Raster plot of events across multiple days, with a row for each day, and a line for each event

`plot_circadian_matrix`: Plot circadian data as a heatmap with a row for each day

`plot_circadian_vector`: Plot the resultant vector of circadian data

`plot_shuffled_vectors`: Scatter plot of the resultant vectors 


### Statistics

`circadian_means`: Get mean or median values of circadian data in time bins around the 24h circadian cycle.

`circadian_rayleigh_test`: Performs a Rayleigh test on circadian data (uses [circstat](https://github.com/circstat/circstat-matlab)'s circ_rtest)

`circadian_vect`: Calculate the resultant vector length and direction of circadian data.

`within_day_shuffle`: Shuffle data values within each day, either as a completely new random permutation or by applying a random circshift.

`get_shuffled_vectors`: Generate a distribution of circadian resultant vectors for shuffled data, and compare the actual resultant vector length with the distribution from the shuffled data to obtain a p-value that represents the probability of observing a circadian vector of this length in the shuffled distribution.


### Utilities

`circadian_plot_aesthetics`: Function to quickly turn MATLAB polar axes into an aesthetically pleasing representation of the 24h circadian cycle.

`subplot_equal_r`: Sets the radius ('r') of multiple polar axes in subplots to the same value.

`fixplot`: Function with a number of quick plot aesthetics fixes for plots in cartesian co-ordinates and/or image (e.g. heatmap) axes.


### Examples & Tutorial

**Work in progress...**

`circadian_summary_figure`: provides an example of how to use many of the regularly sampled data visualisations in the toolbox.

`circadian_event_figure`: provides an example of how to use the event-based visualisations in the toolbox.


## Dependencies

This toolbox makes use of a number of the circular statistics functions in [circstat_matlab](https://github.com/circstat/circstat-matlab)


## Author
This toolbox was developed by:

Dr. Joram J. van Rheede

MRC Brain Network Dynamics Unit

University of Oxford, UK

*e-mail*: joram.vanrheede@bndu.ox.ac.uk
