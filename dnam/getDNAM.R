# Use Methylation download function from TCGA2STAT package
# http://www.liuzlab.org/TCGA2STAT/ 
source('tcga2stat.R')

# Disease code to download
CODE = "LUAD"
#methyl <- getTCGA(disease="xxxx", data.type="Methylation", type="450K")
methyl <- getTCGA(disease=CODE, data.type="Methylation")

#save(methyl, file="methyl-esca.RData")
save(methyl, file=paste0("r-obj-",CODE,".Rdata"))

data = methyl$dat 
print(dim(data))

write.table(data,file=paste0(CODE,"-methyl",".txt"), append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)

samples <- colnames(data)
parsed <- strsplit(samples,"-")
parsed <- lapply(parsed, `[[`, 4)
parsed <- unlist(parsed, recursive=FALSE)


# see distribution of primary tumors, metastatic, and normal tissue
print(table(parsed))


colnames(data) <- gsub(pattern='-', replacement='_', x=colnames(data))
t_data <- t(data)
t_data = as.data.frame(t_data)
t_data$type = c(rep(CODE,nrow(t_data)))

# some row name bs lol 
t_data <- cbind(Row.names = rownames(t_data), t_data)

write.table(t_data,file=paste0(CODE,"-methyl-labeled",".txt"), append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)


