#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)

file_one <- args[1] # ids that you are looking for
file_two <- args[2] # alls possible ids

df1 <- read.table(file = file_one,header = F)
df2 <- read.table(file = file_two,header = F)

df1 = as.vector(df1[,1])
df2 = as.vector(df2[,1])

df1[df1 %in% df2]

