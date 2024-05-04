#!/bin/bash

mkdir -p simulations/wf

for N in 50 100 250 500 1000; do
    for REP in {1..10}; do
        slim -d N=${N} -d OUTPUT=\"${N}_${REP}\" slim/wf.slim
    done
done 

gzip simulations/wf/*