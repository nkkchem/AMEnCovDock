#!/bin/bash
#SBATCH -A mtcovid
#SBATCH -N 5 
#SBATCH -J 6wqf
#SBATCH -t 1:00:00
##SBATCH --gres=gpu:2
#SBATCH -n 24



./launcher_constance.sh


