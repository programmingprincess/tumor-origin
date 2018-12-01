
message("Getting OV data...")
ov <- read.table("OV-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

message("Getting BRCA data...") 
brca <- read.table("BRCA-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

message("Ready to merge") 
data <- merge(ov, brca, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

message("Transposing") 
t_data = t(data)


t_data = as.data.frame(t_data)
t_data$type <- c(rep('brca',ncol(brca)),rep('ov',ncol(ov)))


#row name bs
t_data <- cbind(Row.names = rownames(t_data), t_data)

write.table(t_data,file='merged.txt', append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)




