# setwd("~/Desktop/tumor-origin")

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


write.table(blca_data, file="blca_data.txt", sep="\t", col.names=TRUE, row.names=TRUE)


## BRCA: breast 
brca_data = getData("miR_counts_brca.txt")
ncol(brca_data)

## CHOL: bile duct 
chol_data = getData("miR_counts_chol.txt")
ncol(chol_data)

## COAD: colon
coad_data = getData("miR_counts_coad.txt")
ncol(coad_data)

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


# merge datasets
# fs_data_list = list(fs_blca_data, fs_brca_data, fs_chol_data, fs_coad_data, fs_esca_data, fs_hnsc_data, fs_kich_data, fs_kirc_data, fs_lich_data, fs_luad_data, fs_prad_data, fs_thca_data, fs_ucec_data, fs_paad_data, fs_skcm_data, fs_ov_data);
# 
# fs_data <- fs_blca_data
# 
# fs_data = merge(fs_data, fs_data_list[[3]])
# row.names(fs_data) <- fs_data$Row.names
# fs_data <- fs_data[,-1]
# 
# for(i in 2:4) {
#   fs_data = merge(fs_data, fs_data_list[[i]])
#   row.names(fs_data) <- fs_data$Row.names
#   fs_data <- fs_data[,-1]
# }

removeNA <- function(temp_data, print=TRUE) {
  cat(paste("Before:", nrow(temp_data), "features", "\n", sep="\t"))
  # miRNAs that have at least 70% sample values that do not equal 0 
  # sample values are the column, hence ncol(temp_data)
  fs <- temp_data[rowSums(temp_data!=0) > round(ncol(temp_data)*.70),] 
  cat(paste("After:", nrow(fs), "features", "\n", sep="\t"))
  return (fs)
}

fs_blca_data = removeNA(blca_data)
fs_brca_data = removeNA(brca_data)
fs_chol_data = removeNA(chol_data)
fs_coad_data = removeNA(coad_data)
fs_esca_data = removeNA(esca_data)
fs_hnsc_data = removeNA(hnsc_data)
fs_kich_data = removeNA(kich_data)
fs_kirc_data = removeNA(kirc_data)
fs_lich_data = removeNA(lich_data)
fs_luad_data = removeNA(luad_data)
fs_prad_data = removeNA(prad_data)
fs_stad_data = removeNA(stad_data)
fs_thca_data = removeNA(thca_data)
fs_ucec_data = removeNA(ucec_data)

fs_paad_data = removeNA(paad_data)
fs_skcm_data = removeNA(skcm_data)
fs_ov_data = removeNA(ov_data)

dim(fs_blca_data)


data <- merge(fs_blca_data, fs_brca_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_chol_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_coad_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_esca_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_hnsc_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_kich_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_kirc_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_lich_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_luad_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_prad_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_stad_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_thca_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_ucec_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_paad_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_skcm_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, fs_ov_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

# write.table(data, file="merged_all.txt", sep="\t", col.names=TRUE, row.names=TRUE)

t_data = t(data)
t_data = as.data.frame(t_data)
t_data$type <- c(rep('blca',ncol(fs_blca_data)), rep('brca',ncol(fs_brca_data)),rep('chol',ncol(fs_chol_data)), rep('coad',ncol(fs_coad_data)),rep('esca',ncol(fs_esca_data)),rep('hnsc',ncol(fs_hnsc_data)),rep('kich', ncol(fs_kich_data)),rep('kirc',ncol(fs_kirc_data)),rep('lich', ncol(fs_lich_data)),rep('luad',ncol(fs_luad_data)),rep('prad',ncol(fs_prad_data)),rep('stad',ncol(fs_stad_data)),rep('thca',ncol(fs_thca_data)),rep('ucec',ncol(fs_ucec_data)),rep('paad',ncol(fs_paad_data)),rep('skcm',ncol(fs_skcm_data)),rep('ov',ncol(fs_ov_data))) 

t_data$type <- as.factor(t_data$type)
t_data[is.na(t_data)] <- 0


write.table(t_data, file="merged_all_labeled.txt", sep="\t", col.names=TRUE, row.names=TRUE)
