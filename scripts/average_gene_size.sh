NAME=$1

# number of bases
BP=`gzcat $NAME | grep -v ">" | tr -d "\n" | wc -c`

# number of genes
GENE_NUMB=`gzcat $NAME | grep ">" | wc -l`

echo "The average gene size"
echo "BP:$BP"
echo "GENE_NUMB:$GENE_NUMB"
echo $BP / $GENE_NUMB | bc