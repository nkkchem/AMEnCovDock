#!/bin/bash
# turns .csv into .smi format
# csv has format    ID,SMILE
# USAGE: ./prepareSMI.sh [FILE1.csv] [FILE2.csv] ...
for x in $@
do awk -F, '{print $2", "$1}' $x | perl -pe 's/\r//' > ${x%.csv}.csv
done
