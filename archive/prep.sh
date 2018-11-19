#!/bin/bash

#sample sheet
SAMPLE_SHEET=$1
MANIFEST=$2

# col 2 is the file names 
# col 8 is the sample type 
# get sample labels from sample sheet
grep "isoforms" $SAMPLE_SHEET | cut -f2,8 > sample_labels.txt


# download data from manifest 
nohup ./gdc-client download -m $MANIFEST > nohup.out &


