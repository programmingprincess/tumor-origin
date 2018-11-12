setwd("~/Desktop/tumor-origin")

##############################
## functions 
##############################

# truncate data names 
trimSamples <- function(cancerSet, npar=TRUE, print=TRUE) {
  newLabels <- list()
  i <- 1
  for(sample in colnames(cancerSet)) {
    if(substring(sample,1,1) == "X") {
      sample <- substring(sample,2,37)
    } else {
      sample <- substring(sample,1,36)
    }
    newLabels[i] = sample
    i<-i+1
  }
  return(newLabels)
}

## BLCA: bladder 
blca_data = read.table("miR_counts_blca.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(blca_data) = trimSamples(blca_data)
dim(blca_data)
# [1] 2186  438
# 2186 miRNAs in 438 samples 
row.names(blca_data) = blca_data$miRNA
blca_data = blca_data[-1]


