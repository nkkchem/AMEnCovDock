for dir in $(ls -d /qfs/projects/MulCME/covid19/docking/qvina/Mpro/6wqf/NaturalSubstrate/Hoshin/ligands/*); do echo "./dock.sh docked_proteins docked_proteins/config.txt ${dir}"; done > parallel_dock_commands.sh



