# AMEnCovDock: Automated Computational Modeling Engine for Non Covalent Molecular Docking

AMEnCovDock (Automated Computational Modeling Engine for Non Covalent Molecular Docking) is an automated workflow that takes an input protein structure and ligand library to perform molecular docking calculations using QuickVina 2.

## Documentation


## Environment:
### Constance

	module load python/anaconda3.2019.3
	source /share/apps/python/anaconda3.2019.3/etc/profile.d/conda.sh
	conda activate gschnet

## Required Files:
	Receptor: pdbqt format
		modify automate.sh to hold this name
	Ligands: csv format
		ID,SMILES
		modify automate.sh to hold this name

	modify line 14 of dock.sh to point to your copy of qvina
    	VINA="/path/to/qvina/bin/qvina02"

	modify run.sbatch to reflect desired sbatch parameters


## ANALYSIS
Once the run is completed, the binding affinities are extracted and sorted from highest to smallest. 	

docked_proteins/scores will have the list of compounds in sorted order with their binding affinities
docked_proteins/docked contains the docked compounds with the .docked extension which is the same as .pdbqt format
