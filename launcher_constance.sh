#!/bin/bash
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#
# N: Number of nodes
# n: Number of MPI task requested.
# NHOSTS: Usually the same as N
# PPN: Process per node.
#
# For chantis: N: 1, n: 56 <56 for small tasks>, NHOSTS:1, PPN: <?>
# Stampede: N: <# of Nodes>, n: <68 per node>, NHOSTS: <# of Nodes> , PPN: <?>

 

#SBATCH -J test 
#SBATCH -N 11 
#SBATCH }}{{--ntasks-per-node 24
##SBATCH -p development
#SBATCH -o 6w9c.o%j
#SBATCH -e 6w9c.err%j
#SBATCH -t 02:00:00
#SBATCH --mail-user=rhemamary.james@pnnl.gov
#SBATCH --mail-type=begin   # email me when the job starts
#SBATCH --mail-type=end     # email me when the job finishes
#          <------ Account String ----->
# <--- (Use this ONLY if you have MULTIPLE accounts) --->
#SBATCH -A mtcovid
#------------------------------------------------------

export LAUNCHER_DIR=/share/apps/launcher/3.5
#module load launcher
module load coreutils/8.26
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE=docked_proteins/dock.sh
export LAUNCHER_WORKDIR=$PWD
#export LAUNCHER_NHOSTS=11
{{export LAUNCHER_NHOSTS=$}}SLURM_NNODES
#export LAUNCHER_PPN=24
{{export LAUNCHER_PPN=$}}SLURM_NTASKS_PER_NODE
export LAUNCHER_SCHED=block
export LAUNCHER_BIND=1


$LAUNCHER_DIR/paramrun












