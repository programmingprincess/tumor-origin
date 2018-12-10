# Neural Networks for detecting tumor origin 

## Workflow: 

#### MicroRNA  
* Download isoforms from 17 different classes of cancer from TCGA 

##### In R, on nano cluster
* Put all samples of the same type into a matrix using rptashkin's TCGA miRNASeq Matrix (rows are features; columns are samples) 
* Merge matrices 
* Transpose 

##### In Python, on nano cluster
* Test random forest baseline (0.95)
* Built keras neural network with 2 hidden layers 
* Adjust hyperparameters to get decent accuracy 
* Plot learning rate against validation accuracy to narrow down LR 
* Plot accuracy vs. epoch for chosen learning rates to tune epoch number 

#### DNA Methylation 
* Download 27k Illumina samples from TCGA using TCGA2STAT 

##### In R, on nano cluster 
* Merge different samples into one big matrix 

##### In Python 
* Baseline models to guage accuracy before feature selection 


## Todo:  
- [x] Does feature selection improve random forest model? 
- [x] Does feature selection improve NNet model? 
- [x] Try KNN, SVM, baselines 
- [x] Work on DNA Methylation data 



