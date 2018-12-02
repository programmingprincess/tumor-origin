
message("Getting OV data...")
ov <- read.table("OV-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

message("Getting BRCA data...") 
brca <- read.table("BRCA-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

coad <- read.table("COAD-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

kirc <- read.table("KIRC-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

luad <- read.table("LUAD-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

lusc <- read.table("LUSC-methyl.txt", header=TRUE, stringsAsFactors=FALSE)

ucec <- read.table("UCEC-methyl.txt", header=TRUE, stringsAsFactors=FALSE)


message("Ready to merge") 
data <- merge(brca, coad, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, kirc, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, luad, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, lusc, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, ucec, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]

data <- merge(data, ov, by="row.names", all=T)
row.names(data) <- data$Row.names
data <- data[,-1]


message("Transposing") 
t_data = t(data)


t_data = as.data.frame(t_data)
t_data$type <- c(rep('brca',ncol(brca)),rep('coad',ncol(coad)),rep('kirc',ncol(kirc)),rep('luad',ncol(luad)),rep('lusc',ncol(lusc)),rep('ucec',ncol(ucec)),rep('ov',ncol(ov)))


#row name bs
t_data <- cbind(Row.names = rownames(t_data), t_data)

write.table(t_data,file='merged.txt', append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)




