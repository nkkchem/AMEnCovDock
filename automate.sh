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

#module load python/anaconda3.2019.3
#source /share/apps/python/anaconda3.2019.3/etc/profile.d/conda.sh
#conda activate gschnet

ligands="input.csv"
receptor="6wqf.pdbqt"

# Prepare Config File
cp $receptor docked_proteins
cd docked_proteins/
/bin/bash ../getConfig.sh $(echo $(pwd)"/$receptor")
cd ..

# Prepare Ligands
cp $ligands ligand_library/input.csv
cd ligand_library
python SMILES_to_pdbqt_files_with_name.py
cp -r ligands ..
cd ..

# modify file paths
pathToLigands=$(echo "ligands")

# Generate parallel dock commands
echo "Generating parallel docks"
/bin/bash ./test.sh $pathToLigands
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
