#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

file_one <- "data/ids.txt" #args[1]
file_two <- "uniprot_ids" #args[2]

df1 <- read.table(file = file_one,header = F)
df2 <- read.table(file = file_two,header = F)

df1 = as.vector(df1[,1])
df2 = as.vector(df2[,1])

df1[df1 %in% df2]

