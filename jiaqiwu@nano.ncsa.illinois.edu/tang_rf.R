
setwd("~/Desktop/tumor-origin")

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

blca_data = read.table("miR_counts_blca.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(blca_data) = trimSamples(blca_data)
dim(blca_data)
# [1] 2186  438
# 2186 miRNAs in 438 samples 
row.names(blca_data) = blca_data$miRNA
blca_data = blca_data[-1]

brca_data = read.table("miR_counts_brca.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(brca_data) = trimSamples(brca_data)
dim(brca_data)
# [1] 2227 1208
# 2227 miRNAs in 1208 samples 
row.names(brca_data) = brca_data$miRNA
brca_data = brca_data[-1]

chol_data = read.table("miR_counts_chol.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(chol_data) = trimSamples(chol_data)
dim(chol_data)
# [1] 1746   46 
# 1746 miRNAs in 46 samples 
row.names(chol_data) = chol_data$miRNA
chol_data = chol_data[-1]

coad_data = read.table("miR_counts_coad.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(coad_data) = trimSamples(coad_data)
dim(coad_data)
# [1] 2149  466
row.names(coad_data) = coad_data$miRNA
coad_data = coad_data[-1]

esca_data = read.table("miR_counts_esca.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(esca_data) = trimSamples(esca_data)
dim(esca_data)
# [1] 2075  201
row.names(esca_data) = esca_data$miRNA
esca_data = esca_data[-1]

# merge datasets

data <- merge(blca_data, brca_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, chol_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, coad_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, esca_data, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

dim(data)
# [1] 4442 2353

t_data = t(data)
t_data = as.data.frame(t_data)
# add label rows to the cancer type
t_data$type <- c(rep('blca',437), rep('brca',1207), rep('chol',45), rep('coad',465), rep('esca',200))
t_data$type <- as.factor(t_data$type)
# make all NA zero
# TODO: should we do this?
t_data[is.na(t_data)] <- 0

# split into train and test 
n = nrow(t_data)
set.seed(30)
ntrain = floor(n*0.70)  # 70% train
ii=sample(1:n, ntrain)

t_data_train = t_data[ii,]
t_data_test = t_data[-ii,]

# undersampling example
# t_train_undersample = subset(t_data_train, type != "brca")

# replace hyphens bc R hates hypens 
names(t_data) <- gsub(pattern='-', replacement='_', x=names(t_data))

# check data frame
# second parameter is first part of dim(data) + 1 to show last col (type)
t_data[c(1, 437,1644,1689,2154,2354),1:3]

# columns that have at least N values that do not equal 0 
fs <- t_data[, which(colSums(t_data != 0) > 1000)] 
# split into train and test 
n = nrow(fs)
set.seed(30)
ntrain = floor(n*0.70)  # 70% train
ii=sample(1:n, ntrain)

fs_train = fs[ii,]
fs_test = fs[-ii,]

# random forest for feaaaaature selection 
# library(randomForest)
# rfmodel <- randomForest(type ~ ., data=t_data_train, importance=TRUE, do.trace=100)
# rfmodel 
library(randomForest)
rfmodel <- randomForest(type ~ ., data=fs_train, importance=TRUE, do.trace=100)
rfmodel 


# rfpred <- predict(rfmodel, newdata=t_data_test)
# table(rfpred,t_data_test$type)
rfpred <- predict(rfmodel, newdata=fs_test)
table(rfpred,fs_test$type)

# rfpred blca brca chol coad esca
# blca  108    0    0    0   17
# brca    2  362    2    0    0
# chol    0    0   12    0    0
# coad    0    0    1  155    4
# esca    0    0    0    0   44
# > (108+362+12+155+44)/nrow(t_data_test)
# [1] 0.9632249

# show importance 
rn <- round(importance(rfmodel), 2)
rn
head(rn[order(rn[,6],decreasing=TRUE),],10)


#library(nnet)
# nnmodel = nnet(type ~ ., t_data,size=5,decay=.1,maxit=1000)
nnmodel = nnet(type ~ ., fs_test,size=5,decay=.1,maxit=1000,MaxNWts=3655)
nnyhat = predict(nnmodel, t_data_test,type="class")

table(nnyhat,fs_test$type)


library(ggplot2)
# ggplot(aes(y=hsa_miR_944, x = type), data = t_data) + geom_boxplot()


