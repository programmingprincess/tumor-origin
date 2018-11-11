#
#
require(limma)
library(edgeR)
# setwd("~/Desktop/tumor-origin")
# blca = read.table("expression_matrix_blca.txt", header=TRUE, stringsAsFactors=FALSE)
# blca$tissue.type = "BLCA"
# blca$file = paste(blca$file,"BLCA",sep=".")
# dim(blca)
# # samples, miRNAs
# 
# chol = read.table("expression_matrix_chol.txt", header=TRUE, stringsAsFactors=FALSE)
# chol$tissue.type = "CHOL"
# chol$file = paste(chol$file,"CHOL",sep=".")
# dim(chol)
# 
# coad = read.table("expression_matrix_coad.txt", header=TRUE, stringsAsFactors=FALSE)
# coad$tissue.type = "COAD"
# coad$file = paste(coad$file,"COAD",sep=".")
# dim(coad)
# 
# esca = read.table("expression_matrix_esca.txt", header=TRUE, stringsAsFactors=FALSE)
# esca$tissue.type = "ESCA"
# esca$file = paste(esca$file, "ESCA", sep=)
# dim(esca)

blca = read.table("miR_counts_blca.txt", header=TRUE, stringsAsFactors=FALSE)
#dge_blca = DGEList(counts=blca[-1])
dge_blca = blca[-1]
# normalization and filtering 
# design matrix rows should match data columns (i.e, MiRNAs)

metadata_blca = read.table("expression_matrix_blca.txt", header= TRUE, stringsAsFactors=FALSE)

design <- paste(metadata_blca$sample.type, sep="")
design <- factor(design)

# remove rows that have consistently low counts 
keep <- filterByExpr(dge_blca, design)
dge_blca <- dge_blca[keep,,keep=="TRUE"]
#dge_blca <- calcNormFactors(dge_blca)

# try limma-trend 
logCPM <- cpm(dge_blca, log=TRUE, prior.count=3)
nDesign <- 1:length(design)

# turn design into a binary vector
# 0 means normal tissue 
# 1 means primary tumor or metastatic 
# 
# i <- 0
# for(sample_type in design) {
#   if (sample_type == "Solid Tissue Normal") {
#     nDesign[i] = 0;
#   } else {  # metastatic or primary tumor
#     nDesign[i] = 1;
#   }
#   i<-i+1
# }
# fit <- lmFit(logCPM, nDesign)
# fit <- eBayes(fit, trend=TRUE)
# topTable(fit, coef=ncol(design))

