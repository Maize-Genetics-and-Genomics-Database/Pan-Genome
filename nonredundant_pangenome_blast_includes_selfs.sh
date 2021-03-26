#!/bin/bash

module load blast+

for q in *_primary.cds.fa; do
                echo $q
                qdescriber=$(basename ${q} | sed -e 's/_primary.cds.fa//')
                echo $qdescriber

  for s in *_primary.cds.nhr; do

                echo $s
                sdescriber=$(basename ${s} | sed -e 's/_primary.cds.nhr//')
                echo $sdescriber

    # Ignore self-comparison and redundant files
    if [ ! -f ${sdescriber}_${qdescriber}_blastn.txt ]; then
        blastn -query ${q} -db ${s%.*} -perc_identity 95 -evalue 1e-10 -outfmt "6 std qlen slen qcovs" -out ${qdescriber}_${sdescriber}_blastn.txt
    fi
  done
done
