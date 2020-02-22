library(data.table)
fileNames <- Sys.glob("*.csv")
for (fileName in fileNames) {
    
    # read old data:
    sample <- read.csv(fileName,
                       header = TRUE,
                       sep = ",")
    
    sample <- transpose(sample)
    
    # overwrite old data with new data:
    write.table(sample, 
                fileName,
                append = FALSE,
                quote = FALSE,
                sep = ",",
                row.names = TRUE,
                col.names = TRUE)
    
}