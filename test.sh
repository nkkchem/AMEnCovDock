# call this script with ./test.sh /path/to/all/ligands
# eg. /qfs/projects/MulCME/covid19/docking/qvina/Mpro/6wqf/NaturalSubstrate/Hoshin/ligands
path=$1
for dir in $(ls -d ${path}/* ); do echo "./dock.sh docked_proteins docked_proteins/config.txt ${dir}"; done > parallel_dock_commands.sh
