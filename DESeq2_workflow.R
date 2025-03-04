#Install the essential libraries
BiocManager::install("DESeq2")
BiocManager::install("airway")

##load the libraries
library(DESeq2)
library(tidyverse)
library(airway)


##GET THE DATA FROM THE AIRWAY PACKAGE##
data("airway")
head(airway)
str(airway)


##read the metadata from the airway package and convert into data frame
sample_info <- as.data.frame(colData(airway))

##Select only second and third column from the data frame
sample_info <- sample_info[,c(2,3)]

##Substitute the words with treated and untreated 
sample_info$dex <- gsub('trt', 'treated', sample_info$dex)
sample_info$dex <- gsub('untrt', 'untreated', sample_info$dex)

##Substitute the column names with cellline and dexamethasone
names(sample_info) <- c('cellLine', 'dexamethasone')


##write the data into a csv file
write.table(sample_info, file = "sample_info.csv", sep = ',', col.names = T, row.names = T, quote = F)


##count the gene expression from the airway package
countsData <- assay(airway)

##write the data into a data frame
write.table(countsData, file = "counts_data.csv", sep = ',', col.names = T, row.names = T, quote = F)


##Now read in the counts data from csv

counts_data <- read.csv("counts_data.csv")
head(counts_data)
view(counts_data)


#read in the sample info 
coldata <- read.csv("sample_info.csv")
head(coldata)
view(coldata)


##making sure that all the row names in coldata matches to the column names in counts_data
all(colnames(counts_data) %in% rownames(coldata))
