setwd("~/Desktop/tumor-origin")

############################################################
## Part 2 
## Following "raw_data_working.R"
## Already transposed 
############################################################

#TODO: library(pROC)...why are $y and $votes not the same length? what do they mean 
#TODO: nnnet with 17 samples 
#TODO: feature selection... 


t_data = read.table("raw_table_labeled.txt", header=TRUE, stringsAsFactors=FALSE)
t_data = as.data.frame(t_data)

t_data$type <- as.factor(t_data$type)
#t_data[is.na(t_data)] <- 0

########################
# 
# blca <- subset(t_data, type=="blca")
# not_blca <- t_data[sample(which(t_data$type != "blca"), nrow(blca)), ]
# ## count cancers in random sample 
# # nrow(subset(not_blca,type=="chol"))
# ## p l o t distribution for not sample
# # qplot(not_blca$type)
# t_blca <- rbind(blca, not_blca)
# 
# n = nrow(t_blca)
# set.seed(30)
# ntrain = floor(n*0.60)  # 70% train
# ii=sample(1:n, ntrain)
# 
# blca_train = t_blca[ii,]
# blca_test = t_blca[-ii,]
# 
# library(randomForest)
# rfmodel <- randomForest(type ~ ., data=blca_train, importance=TRUE, do.trace=100)
# rfpred <- predict(rfmodel, newdata=blca_test)
# # table(rfpred, blca_test$type)
# 
# 
# rfpred <- predict(rfmodel, newdata=blca_test, type = "prob")
# library(pROC)
# rfroc <- roc(blca_test$type, rfpred[,2]) # Draw ROC curve.
# plot(rfroc, print.thres="best", print.thres.best.method="closest.topleft")
# auc(rfroc)
# 
# # rfroc <- roc(blca_test$type, rfpred[,2])
# # plot(rfroc)
# # auc(rfroc)

####################################################
## Model Training
####################################################
# split into train and test 
n = nrow(t_data)
set.seed(30)
ntrain = floor(n*0.50)  # 70% train
ii=sample(1:n, ntrain)

data_train = t_data[ii,]
data_test = t_data[-ii,]


library(randomForest)
rfmodel <- randomForest(type ~ ., data=data_train, importance=TRUE, do.trace=100)


##################################################
## Random Forest 
##################################################

rfpred <- predict(rfmodel, newdata=data_test, type="prob")
table(rfpred,data_test$type)

library(pROC)
rfroc <- roc(data_test$type, rfpred[,2]) # Draw ROC curve.
plot(rfroc, print.thres="best", print.thres.best.method="closest.topleft")
auc(rfroc)


##################################################
## Neural Net
##################################################

library(nnet)
nnmodel = nnet(type ~ ., data_train,size=5,decay=.1,maxit=1000,MaxNWts=12122)

## AUC 
nnraw = predict(nnmodel, data_test,type="raw")
nnroc <- roc(data_test$type, nnraw[,2]) # Draw ROC curve.

plot(nnroc, print.thres="best", print.thres.best.method="closest.topleft",print.auc = TRUE,col="blue")
auc(nnroc)

## Confusion Matrix
nnclass = predict(nnmodel, data_test,type="class")
table(nnclass,data_test$type)

## lol idk 
rs <- lolroc[['rocs']]
plot.roc(rs[[1]])
sapply(2:length(rs),function(i) lines.roc(rs[[i]],col=i))

doRF <- function(cancer,npar=TRUE,print=TRUE) {
  #COUNT number of brca, blca...etc. 
  #SAMPLE randomly
}


