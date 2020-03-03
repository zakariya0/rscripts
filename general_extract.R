library(plyr)
library(data.table)
library(gtools)
library(tidyr)
library(dplyr)

filenames <- list.files(full.names=TRUE)
filenames <- setNames(filenames , filenames)
All <- lapply(filenames,function(i){read.csv(i, header=FALSE, skip=1)})
df <- rbindlist(All, fill=TRUE, idcol=filenames)

name <- getwd()
#regular expression
#a <- gsub("//","",name) 
#a <- gsub("/","-",name) 
folderName <- basename(dirname(name))
filename1 <- basename(name)
#filecols <- c(folderName, filename1) 
newdf1 <- cbind(folderName, filename1, df)
#here we added the name of the drug folder and super folder
#can remove the super folder column by deleting (folderName) from cbind
#newdf1 = select(newdf1, -4)
#use the above command for amphetamine because of useless column

a <- (ncol(newdf1)-4)/3
#this is about counting the number of biological replicates
#it's not usually 5 columns to repeat could be 4 or 3.

#a loop to stack biological replicates on top of each other to automate it
final <- data.frame(newdf1)
b <- 5
d <- 1
final3 = final[FALSE,]
#final3 <- c(1:4)
##for(i in 1:length(a))
for(i in 1:a)
{
#   b <- 6
    c1 <- (b+2)
#   sub <- table [,b:(b+2)]
#    sub <- table(b:c)
    sub <- subset(final, select=c(b:c1))
    final2 <- subset(final, select=c(1:4))
##  biorep <- c("Biological replicate")
    temp <- cbind(final2, sub, biorep=d)
    
    colnames(final3) = colnames(temp)
    
    final3 <- rbind(final3, temp)
    
    #this is about biological replicate numbers
##  final3 <- bind_rows(final3, temp)
##  final <- rbind (final,sub)
    

    b <- b+3
    d <- d+1
}

##final <- final[which(is.na(final V2)),]
#don't really get this

##colnames()[6:8]<-c("T1","T2","T3")
##library(tidyr)
# gather or spread ... from wide to long format 
colnames(final3)[1:8] <- c("drug type", "drug", "hormone", "drugconc", "t1", "t2", "t3", "biorep")
data_long <- gather(final3, techrep, hormoneconc, t1, t2, t3, factor_key=TRUE)

# select by regular expression the outliers 
# create new column with flag of outliers 
        
write.csv(data_long,"all_hormones.csv", row.names=FALSE)



