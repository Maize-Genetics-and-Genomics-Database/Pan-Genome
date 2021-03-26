#!/bin/bash

module load blast+

#looping blastdb:

for sample in *_primary.cds.fa
        do
                echo $sample
                describer=$(echo ${sample} | sed 's/_primary.cds.fa//')
                echo $describer

makeblastdb -in ${sample} -dbtype nucl -out ${describer}_primary.cds

done
