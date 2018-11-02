#!/usr/bin/bash

NAME=$1

# number of bases
BP=`zcat $NAME | grep -v ">" | tr -d "\n" | wc -c`

# number of genes
GENE_NUMB=`zcat $NAME | grep ">" | wc -l`

echo "The average gene size"
echo $BP / $GENE_NUMB | bc
