#!/bin/bash 
#PBS -k o 
#PBS -l nodes=1:ppn=1,walltime=90:00 
#PBS -M jiaqiwu6@illinois.edu
#PBS -N rGetDataMatrix

cd $PBS_O_WORKDIR

Rscript get_Matrix.R

