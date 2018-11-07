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
dge_blca = DGEList(counts=blca[-1])

# normalization and filtering 
# design matrix rows should match data columns (i.e, MiRNAs)

metadata_blca = read.table("expression_matrix_blca.txt", header= TRUE, stringsAsFactors=FALSE)

design <- paste(metadata_blca$sample.type, sep="")
design <- factor(design)

# remove rows that have consistently low counts 
keep <- filterByExpr(dge_blca, design)
dge_blca <- dge_blca[keep,,keep.lib.sizes=FALSE]