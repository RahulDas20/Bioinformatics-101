#Script to manipulate gene expression data
#set working directory


#load the essential library
library(dplyr)
library(tidyverse)
install.packages("GEOquery")
BiocManager::install("GEOquery")
library(GEOquery)



#read in the data in R
data <- read.csv("Data/GSE183947_fpkm.csv")


#get metadata 
gse <- getGEO(GEO = "GSE183947", GSEMatrix = TRUE)


#extract the phenotypic data
metadata <- pData(phenoData(gse[[1]]))

view(metadata)

#let's select the important columns from the metadata
metadata_subset <-select(metadata, c(1, 10, 11,17))

view(metadata_subset)

metadata_modified <- metadata %>% 
  select(1, 10, 11,17) %>%
  rename(tissue = characteristics_ch1) %>%
  rename(metastasis = characteristics_ch1.1) %>%
  mutate(tissue = gsub("tissue: ", "", tissue)) %>%
  mutate(metastasis = gsub("metastasis: ", "", metastasis))

head(metadata_modified)

head(data)

#reshaping data into long format
data_long <- data %>%
  rename(gene = X) %>%
  gather(key = "sample", value = 'FPKM', -gene)


view(data_long)


#join_both_data frame = data_long + metadata_modified

complete_data <- data_long %>%
  left_join(.,metadata_modified, by = c("sample" = "description"))


#