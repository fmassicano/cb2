#!/usr/bin/bash

NAME=$1

head=`zcat 9606.tsv.gz | head -n 3 | sed -e 's/#//g' -e 's/\<|\>//g'`

data=`zcat 9606.tsv.gz | grep -v "^#" |sed -e 's/\t/,/g'`

# unique domains
`zcat 9606.tsv.gz | grep -v "^#" | cut -f 1 | sort | uniq | wc -l`

`zcat 9606.tsv.gz | grep -v "^#" | cut -f 7 | sort | uniq -c | sort -n | tail`

# 
zcat 9606.tsv.gz | grep -v "^#" | cut -f 1 | sort | uniq -c | sort -gr | head 

zcat 9606.tsv.gz | grep -v "^#" | cut -f 7 | grep 'SH3' | sort | uniq -c | sort-gr | head