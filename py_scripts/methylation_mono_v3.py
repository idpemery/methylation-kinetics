#!/usr/bin/python
 #-*- coding: latin-1 -*-

#This script 'cleans up' real-time kinetics data in Topspin
#for export into a text file. Data may be processed
#further in accompanying Python scripts.   
#@author: emeryusher

#import a bunch of junk that Topspin needs; this came from sample scripts online
import os, sys, re
import xml.etree.ElementTree as ET
import de.bruker.nmr.mfw.root.UtilPath as UtilPath
from javax.swing import JOptionPane

#input whole path for where your Topspin data is stored
directory = 'C:\Users\emery\NMR_data\NMR_H3'
#ensure the experiment file name is inputted below exactly as it is in Topspin
expName = "200519_methylation_kinetics_PRDM9"
#numOfExp will be the number of files + 1 (so if you have 112 experiment files, enter 113
numOfExp = 111
#use the cursor to find the window where the desired peak is located
#must use the value of the ROW (above and below the peak, in Hz), not the column
peakRanges = [(607,632)]
#this tells the script where to save the resulting 1D spectrum
#no need to create a new directory for this
procno = '101'
#loop to sequentially process each experiment file into a 1D slice
for i in range(1, numOfExp):
	#"1" refers to the file that contains the 2D spectrum
	#'graceusher' is the root folder; replace with your version of this
	RE([expName, str(i), "1", directory], "n")
	#before running the script, use Experiment 1 to perform a phase correction on the SAM peak
	#go into Procpars to find the final value, then enter the values below
	#PHC0 refers to a zero order phase correction, while PHC1 is first order
	XCMD('PHC0 -120.6 0')
	XCMD('PHC1 0 0')
	#the next three lines perform a baseline correction to suppress the water/buffer signal
	XCMD('2 BCFW 0.6')
	XCMD('2 BC_mod qfil')
	XCMD('2 COROFFS 1000')
	XCMD('xfb nc_proc 4')
	#the next lines process the 2D file with the corrections and then slice data into a 1D
	XCMD('xfb')
	XCMD('f2sum' + ' ' + str(peakRanges[0][0]) + ' ' + str(peakRanges[0][1]) + ' ' + procno + ' n')
	XCMD('close')
	#this line tells Topspin where the output files should go
	RE([expName, str(i), procno, directory])
	#IMPORTANT: you must create the director "Kinetics_Analysis_mono", word for word in the directory
	#where the experiment files are located.
	XCMD('totxt ' + str(directory) + '/' + str(expName) + '/Kinetics_Analysis_mono/' + str(i)+'.txt')
	#the result of this script is 112 text files that you will feed into "1D_combiner" script in a python environment
