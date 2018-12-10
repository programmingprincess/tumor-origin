# Neural Networks for detecting tumor origin 

MircoRNA results available in `analysis.ipynb`, viewable [here](https://nbviewer.jupyter.org/github/programmingprincess/tumor-origin/blob/master/analysis.ipynb)

DNAm results availabile in `analysis-dnam.ipynb`, viewable [here](https://nbviewer.jupyter.org/github/programmingprincess/tumor-origin/blob/master/analysis-dnam.ipynb) 

## Workflow: 

#### MicroRNA  
* Download isoforms from 17 different classes of cancer from TCGA 

##### In R, on nano cluster
* Put all samples of the same type into a matrix using rptashkin's [TCGA_miRNASeq_Matrix](https://github.com/rptashkin/TCGA_miRNASeq_matrix) (rows are features; columns are samples) 
* Merge matrices 
* Transpose 
* Randomize, split labels 

##### In Python, on nano cluster
* Select features based on low NA-values
* Put all samples of the same type into a matrix using rptashkin's TCGA miRNASeq Matrix (rows are features; columns are samples) 
* Merge matrices 
* Transpose 

##### Jupyter notebook
* Test random forest, knn, and svm baselines 
* Visualize keras tuning data from cluster 
* Attempt cross validation 

#### DNA Methylation 
* Download 27k Illumina samples from TCGA using TCGA2STAT 

##### In R, on nano cluster 
* Get data from TCGA using `tcga2stat.R`
* Select features based on low NA-values
* Select for high variability (20-80 percentile)
* Merge samples into one data matrix
* Randomize, split labels  

##### In Python, on nano cluster
* Baseline models to guage accuracy before feature selection 
* Tune nnet hyperparameters 

##### Jupyter Notebook
* Visualize tuning data 

## Todo:  
- [x] Does feature selection improve random forest model? 
- [x] Does feature selection improve NNet model?
- [ ] Scaling (0,1)
- [x] Try KNN, SVM, baselines 
- [ ] High variability feature selection 
- [x] Process methylation data 
- [ ] Import additional metastatic datasets 
- [ ] Attempt on non-TCGA datasets 

## References
- Tang, W. et al. (2017). Tumor origin detection with tissue-specific miRNA and DNA methylation markers. Bioinformatics, 34:3. [https://doi.org/10.1093/bioinformatics/btx622][https://doi.org/10.1093/bioinformatics/btx622]

- Zhuang, J. et al. (2012). A comparison of feature selection and classification methods in DNA methylation studies using the Illumina Infinum platform. [https://doi.org/10.1186/1471-2105-13-59][https://doi.org/10.1186/1471-2105-13-59]

*This work utilizes resources supported by the National Science Foundation's Major Research Instrumentation program, grant #1725729, as well as the University of Illinois at Urbana-Champaign*


