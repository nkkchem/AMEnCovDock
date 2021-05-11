#!/bin/bash
#SBATCH -A mtcovid
#SBATCH -N 5 
#SBATCH -J 6wqf
#SBATCH -t 1:00:00
##SBATCH --gres=gpu:2
#SBATCH -n 24



./launcher_constance.sh

# Score Results
cat docked_proteins/results/run_* > docked_proteins/results/runs
sort -t, -nk2 docked_proteins/results/runs > docked_proteins/scores
