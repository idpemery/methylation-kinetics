# -*- coding: utf-8 -*-
"""
This script combines numbered text files (1Ds) that are outputted
as a result of running the methylation cleanup .py script in Topspin on
RT-methylation NMR data. To setup:

    1. Save this script in the the "Kinetics_Analysis_xyz" folder
    that was created for Topspin processing
    2. Click 'run'
    3. Follow the prompts to input the first file number, the number of
    files you wish to import, and the desired name of the output file
    (ie, "monomethyl" or "dimethyl", etc.)

The output file, a 1D array of file maxima, will be saved into
the folder where this file is saved.

NB: This scripts determines the absolute maximum from a 1D NMR spectrum file;
    if there are additional peaks (ie, buffer or cofactor) that are NOT related
    to the signal of interest, you may wish to add a line here that narrows the
    window for the maximum value search.

Created on Fri Apr 3 2020
@author: emeryusher
// emeryusher95@gmail.com or @idpemery on Twitter
"""
#import modules
import numpy as np

#user prompt for first experiment number (usually 1 or 2)
file_start = int(input('What is the expno for the first timepoint? '))
#user prompt for the number of timepoints (number of files)
num_files = int(input('How many timepoint files would you like to import? '))

#create empty array "data_list"
data_list = []

#loop opens all text files and creates a list
for x in range (file_start, num_files):
    data_list.append(np.loadtxt('{0}.txt'.format(x+1)))

#creates array with the maxima of each data set
max_array = []
for i in range (len(data_list)):
    max_array.append(np.max(data_list[i]))

#save array of maxima as a text file with specified name
filename = str(input('What is the desired title for the output .txt file? '))
np.savetxt(str(filename)+'.txt', max_array)
