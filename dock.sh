#!/bin/bash
if [ ! $# -eq 3 ]; then
   echo "Usage: dock.sh <output_dir> <config> <ligands>"
   echo "Example: dock.sh ./output proteins/5r80.config ./ligands"
   exit 1
fi

WORKDIR=$PWD
OUTPUTDIR=$(realpath $1)
CONFIG=$(realpath $2)
LIGANDS=$(realpath $3)
DOCKDIR=$OUTPUTDIR/docked; mkdir -p $DOCKDIR
RESULTS=$OUTPUTDIR/results; mkdir -p $RESULTS
VINA="/qfs/projects/MulCME/Rhema/Project/docking/qvina/bin/qvina02"


my_grep=`which grep`
my_awk=`which awk`

for ligand in "$LIGANDS"; do
   outputfile="$DOCKDIR"/$(basename -- ${ligand%.*}).docked
   vina="timeout 300s $VINA --ligand $ligand --config $CONFIG --out $outputfile > /dev/null;"
   parse="echo \"${ligand},\$($my_grep -m 1 \"REMARK VINA RESULT:\" ${outputfile} | $my_awk '{ print \$4 }')\" >>  ${RESULTS}/run_\$LAUNCHER_TSK_ID "
   #parse="echo \"$( basename ${outputfile} .docked ),\$($my_grep -m 1 \"REMARK VINA RESULT:\" ${outputfile} | $my_awk '{ print \$4 }')\" >>  ${RESULTS}/run_\$LAUNCHER_TSK_ID "
   echo "$vina $parse"
   
done > "$OUTPUTDIR"/dock_"$(basename ${LIGANDS})".sh
