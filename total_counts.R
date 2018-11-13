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

getData <- function (file, print=TRUE) {
  temp_data = read.table(file, header=TRUE, stringsAsFactors=FALSE)
  colnames(temp_data) = trimSamples(temp_data)
  
  row.names(temp_data) = temp_data$miRNA
  temp_data = temp_data[-1] #trim repeated rownames 
  
  return(temp_data)
}
## BLCA: bladder 
blca_data = getData("miR_counts_blca.txt")
ncol(blca_data)   # number of samples 
#nrow(blca_data)   # number of miRNAs

## BRCA: breast 
brca_data = getData("miR_counts_brca.txt")
ncol(brca_data)

## CHOL: bile duct 
chol_data = getData("miR_counts_chol.txt")
ncol(chol_data)

## ESCA: esophagus 
esca_data = getData("miR_counts_esca.txt")
ncol(esca_data)

## HNSC: head and neck 
hnsc_data = getData("miR_counts_hnsc.txt")
ncol(hnsc_data)

## KICH: kidney chromophobe 
kich_data = getData("miR_counts_kich.txt")
ncol(kich_data)

## KIRC: kidney renal clear cell 
kirc_data = getData("miR_counts_kirc.txt")
ncol(kirc_data)

## LICH: liver 
lich_data = getData("miR_counts_lich.txt")
ncol(lich_data)

## LUAD: lung 
luad_data = getData("miR_counts_luad.txt")
ncol(luad_data)

## PRAD: prostate 
prad_data = getData("miR_counts_prad.txt")
ncol(prad_data)

## STAD: stomach 
stad_data = getData("miR_counts_stad.txt")
ncol(stad_data)

## THCA: thyroid 
thca_data = getData("miR_counts_thca.txt")
ncol(thca_data)

## UCEC: uterus 
ucec_data = getData("miR_counts_ucec.txt")
ncol(ucec_data)


#####
## PAAD: pancreas 
paad_data = getData("miR_counts_paad.txt")
ncol(paad_data)

## SKCM: skin melanoma 
skcm_data = getData("miR_counts_skcm.txt")
ncol(skcm_data)

## OV: ovary 
ov_data = getData("miR_counts_ov.txt")
ncol(ov_data)