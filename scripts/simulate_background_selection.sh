#!/bin/bash

mkdir -p simulations/background/


for R in 1e-8 1e-9; do
    for REP in {1..10}; do
        slim -d N=500 -d OUTPUT=\"${R}_${REP}\" -d R=${R} slim/background.slim
    done
done

gzip simulations/background/*
