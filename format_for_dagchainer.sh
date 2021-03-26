#!/bin/bash

for sample in *_blastn.txt
        do
                echo $sample
                describer=$(echo ${sample} | sed 's/_blastn.txt//')
                echo $describer

cat ${sample} | cut -f 1,2,3,11 | sort | join - pangenome_all_genomes_coords_sorted | tr ' ' '\t' | sort -k2,2 | join -1 2 -2 1 - pangenome_all_genomes_coords_sorted | tr ' ' '\t' | awk -v OFS="\t" '{if($5 == $8) print $5"_A",$1,$6,$7,$8"_B",$2,$9,$10,$4}' > ${describer}_dagchainer.txt
        
        done
