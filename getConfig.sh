#!/bin/bash

# This script spawns an agfr session to acquire the box configuration for blind docking and produce the config file for AMEnCovDock
# since agfr detects the size of the system, and prints it in the initial print statement, this script runs agfr until the desired parameter is seen "Box center", which will also capture everything else needed for AMEnCovDock config

# USAGE: ./getConfig absolute/path/to/receptor.pdbqt

# Programmer: Darin Hauner
# 	Date: 3/26/2021

###### Get Box ######
receptor=$1

echo Finding Box for $receptor

expect -c "spawn agfr -r "$receptor"; expect \"Box center\" { close }" > output
boxCenter=$(grep "Box center" output)
boxSize=$(grep "Box size" output)
read -r -a boxCenterArray <<< "$boxCenter"
read -r -a boxSizeArray <<< "$boxSize"


###### Create Config ######
echo Generating Config File
config="config.txt"
echo receptor = $receptor > $config
echo >> $config
echo center_x = ${boxCenterArray[2]} >> $config
echo center_y = ${boxCenterArray[3]} >> $config
echo center_z = ${boxCenterArray[4]} >> $config
echo >> $config
echo size_x = ${boxSizeArray[3]} >> $config
echo size_y = ${boxSizeArray[4]} >> $config
echo size_z = ${boxSizeArray[5]} >> $config
echo >> $config
echo num_modes = 25 >> $config

###### CLEAUNUP ######
rm output

###### Finished ######
#cat $config
echo Done!
