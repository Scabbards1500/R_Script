BiocManager::install("corrplot") 
library(corrplot)
#这个包是用来处理表头的
library(dplyr)

setwd("D:\\R_Bio\\rscript\\temp")

# 清空工作环境
rm(list = ls())


options(stringsAsFactors = F)
a = read.table('K.bam.txt')
colnames(a) = a[1,]
a = a[2:nrow(a),]
b = read.table('lyz-K.bam.txt')

meta = a[,1:6]
exprSet = a[,6:7]
# exprSet = a[,7:ncol(a)]

colnames(exprSet)
corrplot(cor(exprSet))

a2 = data.frame(id = meta[,1],a2=a2)

