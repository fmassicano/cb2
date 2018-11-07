#!/usr/bin/bash

ID_FILES=$1

# cat vogelstein_tsg.txt | xargs -I{} echo "wget http://www.uniprot.org/uniprot/?query=organism:9606+AND+gene:GeneID&format=tab&columns={} | tail -n+2 | head -n 1"

for i in `cat $ID_FILES`
do
 wget -q -O - "http://www.uniprot.org/uniprot/?query=organism:9606+AND+gene:$i&format=tab&columns=id" | tail -n+2 | head -n 1
done

 

