#!/usr/bin/python3
# Author: Nicholas LaJoie
# File: mars_to_mif.py
# Date: November 22, 2017
# Description: Converts a .txt file dumped in hex format from MARS into a .mif file. Created for all my pals in ECE 473.
# Usage: $python mars_to_mif.py [input.txt] (optional)[output]
# >> python mars_to_mif.py test7.txt seven
# >> ls
# mars_to_mif.py   test7.txt   seven.mif

# 
# To use:
# Create whatever assembly program your heart desires in MARS
# Hit "Ctrl-D" (or "Command-D") to open "Dump Memory To File" in MARS
# Select whichever memory segment you want to dump
# Select "Hexadecimal Text" as the dump format and save it as a .txt file
# Run the python script with the .txt file as the first argument and a name for the .mif file as the second argument (optional, and don't include ".mif") 
# Load up that beautiful .mif file into Quartus and get back to work on Milestone 3


# Packages
import sys

# Variables
temp = """
DEPTH = 64;\t\t% Memory depth and width are required     %
WIDTH = 32;\t\t% Enter a decimal number                  %
ADDRESS_RADIX = HEX;\t% Address and value radixes are optional  %
DATA_RADIX = HEX;\t% Enter BIN, DEC, HEX, or OCT; unless     %
\t\t\t% otherwise specified, radixes = HEX      %
-- Specify initial data values for memory, format is address : data \n
CONTENT BEGIN
[00..3F] : 00000000;\t% Range - Every address from 00 to 3F = 00000000 % \n
-- Initialize data\n"""

# Get command line arguments
if len(sys.argv) < 2:
	print("ERROR: Please format as >> [script] [input.txt] (optional)[output]")
	exit()

# Open MARS hex file dump (.txt) as read-only
txt = sys.argv[1]
if txt.endswith('.txt'):
	f1 = open(sys.argv[1],'r')
else:
	print("ERROR: Improper input type. Must be .txt")
	exit()

# Use command line output file name if provided
if len(sys.argv) == 3:
	f_out = sys.argv[2] + '.mif'
else:
	f_out = 'out.mif'

# Create .mif file to write to
f2 = open(f_out, 'w+')

# Get instructions in hex from text file
h = f1.readlines()

# Write file header
f2.write(temp)

# Fill .mif file with provided instructions
padding = 1
for i, h in enumerate(h):
	if i >= 64:
		padding = 0
		break
	f2.write("{0:0{1}X}".format(i,2) + ' : ' + h.strip() + ';\n')

# Pad the remainder of the .mif file with 0's (NOPs)
if padding == 1:
	f2.write("[" + "{0:0{1}X}".format(i+1,2) + "..3F] : 00000000;\t % nop %")

f2.write("END;")

# Close it out
f1.close()
f2.close()
