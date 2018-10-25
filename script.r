chol <- list.files(".", pattern="*.quantification.txt")
chol_data_list <- lapply(chol, function(x){ read.table(x, colClasses=c('character','character','numeric','numeric', 'NULL','character'), header=T)})
chol_data <- Reduce(function(x,y) {merge(x,y,by='miRNA_ID')}, chol_data_list)