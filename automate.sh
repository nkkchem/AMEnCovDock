#!/bin/bash
# This script performs the steps for docking proteins
# Before use:
#    must have cloned https://github.com/QVina/qvina
#    modify dock.sh
#        VINA="/path/to/cloned/qvina/bin/qvina02"
#    

# To clean up
#   rm parallel_dock_commands.sh
#   rm -R docked_proteins/results
#   rm -R docked_proteins/docked
#   rm docked_proteins/dock.sh

# modify file paths
### This section is here in case of further automation

# Generate parallel dock commands
echo "Generating parallel docks"
/bin/bash ./test.sh
module load coreutils/8.26
# make parallel docks executable
chmod u+x parallel_dock_commands.sh
/bin/bash ./parallel_dock_commands.sh

# compile them into a single file
echo -n "Compiling docks"
cat docked_proteins/dock_* > docked_proteins/dock.sh

# cleanup files (rm docked_proteins/dock_*.pdbqt.sh )
echo -n "Cleaning docks\n"
rm docked_proteins/dock_*.pdbqt.sh

# submit batch script
sbatch run.sbatch
