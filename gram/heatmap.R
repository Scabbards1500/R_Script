#heatmap
setwd("D:/R_Bio/rscript/heatmap")

library(readr)
library(plyr)
library(readxl)
library(RColorBrewer)
library(pheatmap)

df = read.csv("39fc4.csv",header = T,row.names = 1)
data = as.matrix(df)
pheatmap(data,cluster_row = FALSE)

