# Circa Diem toolbox
Matlab toolbox for plotting and analysis of circadian patterns in data.
 
The Circa Diem toolbox is designed to generate circadian visualisations and analyses of data points with associated Matlab 'datetime' values.

Circa Diem also allows for some statistical tests of the extent of non-uniformity of circadian patterns. For this, the toolbox is heavily indebted to the 'circstat_matlab' toolbox by Philipp Berens (some of the statistical functions are essentially wrapper functions around circstat functions).

# Contents

## Plotting

'<circadian_rose>': Rose plot of circadian data

plot_circadian_matrix: Plot circadian data as a heatmap with a row for each day

plot_circadian_vector: Plot the resultant vector of circadian data

plot_shuffled_vectors: Scatter plot of the resultant vectors 


# Dependencies
This toolbox makes use of a number of the circular statistics functions in 'Circstat':
https://github.com/circstat/circstat-matlab

