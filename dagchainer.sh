#!/bin/bash

for sample in *_dagchainer.txt
        do
                echo $sample
                describer=$(echo ${sample} | sed 's/_dagchainer.txt//')
                echo $describer

perl /DAGCHAINER/accessory_scripts/filter_repetitive_matches.pl 1000000 < ${sample} > ${describer}_dagchainer_tandem.filtered

perl /DAGCHAINER/run_DAG_chainer.pl -i ${describer}_dagchainer_tandem.filtered -s -I -D 1000000 -g 40000 -A 5
       done
