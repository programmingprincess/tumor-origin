
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
#
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


####
# PAAD: pancreas
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
  #temp_data <- temp_data[rowSums(temp_data!=0) > round(ncol(temp_data)*.70),] 
  cat(paste("After:", nrow(temp_data), "features", "\n", sep="\t"))
  return (temp_data)
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
# 
# dim(fs_blca_data)

#########################################################
## Data below has been merged using nano_total_counts.R 
## Using the feature selected values 
########################################################

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
#
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

# data = read.table("merged_all.txt", header=TRUE, stringsAsFactors=FALSE)
# data_labeled = read.table("merged_all_labeled.txt", header=TRUE, stringsAsFactors=FALSE)
#
# data_labeled$type <- as.factor(data_labeled$type)


t_data = t(data)
t_data = as.data.frame(t_data)
t_data$type <- c(rep('blca',ncol(fs_blca_data)), rep('brca',ncol(fs_brca_data)),rep('chol',ncol(fs_chol_data)), rep('coad',ncol(fs_coad_data)),rep('esca',ncol(fs_esca_data)),rep('hnsc',ncol(fs_hnsc_data)),rep('kich', ncol(fs_kich_data)),rep('kirc',ncol(fs_kirc_data)),rep('lich', ncol(fs_lich_data)),rep('luad',ncol(fs_luad_data)),rep('prad',ncol(fs_prad_data)),rep('stad',ncol(fs_stad_data)),rep('thca',ncol(fs_thca_data)),rep('ucec',ncol(fs_ucec_data)),rep('paad',ncol(fs_paad_data)),rep('skcm',ncol(fs_skcm_data)),rep('ov',ncol(fs_ov_data))) 
#t_data$type <- c(rep('1',ncol(fs_blca_data)), rep('2',ncol(fs_brca_data)),rep('3',ncol(fs_chol_data)), rep('4',ncol(fs_coad_data)),rep('5',ncol(fs_esca_data)),rep('6',ncol(fs_hnsc_data)),rep('7', ncol(fs_kich_data)),rep('8',ncol(fs_kirc_data)),rep('9', ncol(fs_lich_data)),rep('10',ncol(fs_luad_data)),rep('11',ncol(fs_prad_data)),rep('12',ncol(fs_stad_data)),rep('13',ncol(fs_thca_data)),rep('14',ncol(fs_ucec_data)),rep('15',ncol(fs_paad_data)),rep('16',ncol(fs_skcm_data)),rep('0',ncol(fs_ov_data))) 
t_data$type <- as.factor(t_data$type)
t_data[is.na(t_data)] <- 0

names(t_data) <- gsub(pattern='-', replacement='_', x=names(t_data))

t_data = t_data[-1]

t_data_random <- t_data[sample(nrow(t_data)),]

#write.table(t_data_random$type, file="types.txt", sep="\t", col.names=TRUE, row.names=TRUE)

#write.table(t_data_random, file="raw.txt", sep="\t", col.names=TRUE, row.names=TRUE)

####################################################
## Split into train/test
####################################################
# split into train and test 
n = nrow(t_data_random)
set.seed(30)
ntrain = floor(n*0.50)  # 70% train
ii=sample(1:n, ntrain)

data_train = t_data_random[ii,]
data_test = t_data_random[-ii,]


####################################################
## Random Forest
####################################################

library(randomForest)
rfmodel <- randomForest(type ~ ., data=data_train, importance=TRUE, do.trace=100)

# save(rfmodel, file="rfmodel_11272018.RData")
# capture.output(rfmodel, file="rfModel_11272018.txt")

rfpred <- predict(rfmodel, data_test)
rfcm <- table(rfpred, data_test$type)
print(paste("Accuracy: ", sum(diag(rfcm))/nrow(data_test)))

# rn <- round(importance(rfmodel), 2)
# rn
#head(rn[order(rn[,6],decreasing=TRUE),],10)

####################################################
## NNet 
####################################################


library(nnet)
nnmodel = nnet(type ~ ., data_train,size=5,decay=.1,maxit=200,MaxNWt=12117)
nnraw = predict(nnmodel, data_test,type="raw")

# save(nnmodel, file="nnmodel_11272018.RData")

nnclass = predict(nnmodel, data_test,type="class")
nncm = table(nnclass,data_test$type)

print(paste("Accuracy: ", sum(diag(nncm))/nrow(data_test)))

## AUC 
# nnraw = predict(nnmodel, data_test,type="raw")
# nnroc <- roc(data_test$type, nnraw[,2]) # Draw ROC curve.
# 
# plot(nnroc, print.thres="best", print.thres.best.method="closest.topleft",print.auc = TRUE,col="blue")
# auc(nnroc)

## Confusion Matrix
nnclass = predict(nnmodel, data_test,type="class")
table(nnclass,data_test$type)