parent.folder <- getwd()
sub.folders <- list.dirs(parent.folder, recursive=TRUE)[-1]
r.scripts <- file.path(parent.folder, "general_extract.r")
# Run scripts in sub-folders 

finaldataframe <- data.frame(matrix(ncol = 7, nrow = 1))
x <- c("drug type", "drug", "hormone", "drugconc", "biorep", "techrep", "hormoneconc")
colnames(finaldataframe) <- x

for(i in sub.folders)
{
    setwd(i)
    
    for (dir in list.dirs()[-1]) 
    {
        # get into the sub directory
        setwd(dir)
        source(r.scripts)
        
        finaldataframe2 <- read.csv("all_hormones.csv", header=TRUE)
        colnames(finaldataframe) = colnames(finaldataframe2)
        finaldataframe <- rbind(finaldataframe, finaldataframe2)
        
        setwd("../")
    }
}

setwd(parent.folder)
write.csv(finaldataframe,"final.csv", row.names=FALSE)
#print the directiory (dir) + all_hormones.csv into new file 

# you have a file with all paths to all_hormones.csv 
# create loop: read the each file 
# rbind
