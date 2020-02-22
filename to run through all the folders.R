parent.folder <- "C:/Users/Zakar/Desktop/H295R data (csv)"
sub.folders <- list.dirs(parent.folder, recursive=TRUE)[-1]
r.scripts <- file.path(parent.folder, "general_extract.r")
# Run scripts in sub-folders 
for(i in sub.folders) 
{
    setwd(i)
    
    for (dir in list.dirs()[-1]) 
    {
        # get into the sub directory
        setwd(dir)
        source(r.scripts)
        setwd("../")
    }
}