#! /bin/bash
CANCER=$1

scp jiaqiwu@nano.ncsa.illinois.edu:cancer/$CANCER-miR/miR_counts_matrix.txt .

mv miR_counts_matrix.txt miR_counts_$CANCER.txt
