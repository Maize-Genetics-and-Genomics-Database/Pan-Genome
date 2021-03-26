#!/bin/bash

for sample in *_dagchainer.txt
        do
                echo $sample
                describer=$(echo ${sample} | sed 's/_dagchainer.txt//')
                echo $describer

perl /DAGCHAINER/run_DAG_chainer.pl -i ${sample} -D 1000000 -g 40000 -A 5

done
