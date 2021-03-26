#!/bin/bash

for sample in *_primary.cds.fa

        do
                echo $sample
                describer=$(basename ${sample} | sed 's/_primary.cds.fa//')
                echo $describer



cat ${describer}_${describer}_blastn.txt | cut -f 1,2,11 | awk -v OFS="\t" '{if($1 != $2) print}' | sort | join - pangenome_all_genomes_coords_sorted | tr ' ' '\t' | awk -v OFS="\t" '{print $2,$1,$4,$5,$6,$3}' | sort | join - pangenome_all_genomes_coords_sorted | tr ' ' '\t' | awk -v OFS="\t" '{print $2,$3,$4,$5,$1,$7,$8,$9,$10,$6}' | awk -v OFS="\t" '{if ($2 == $6 && $3>($7-150000) && $3<($7+150000))print $1,$5}' | sed -e 's/_T[0-9]*//g' | sort > ${describer}_3Mb_tandem_window.txt

done
