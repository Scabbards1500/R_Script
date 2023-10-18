library(DiffBind)
library(tidyverse)
library(edgeR)
setwd("F:\\HY\\220726diffbind")
samples <- read.csv('Hepatocyte.csv')
file.info(samples$Peaks)

#一键analysis
#merge<-dba.analyze("diffbind_merge.csv")
#dbObj <- dba(sampleSheet=samples)

#读取文件
dbObj <- dba(sampleSheet=samples)

#分析文件
#dbObj_blacklist<-dba.blacklist(dbObj) 
dbObj_count<-dba.count(dbObj,summits=FALSE) 
#dbObj_count<-dba.normalize(dbObj_count) 

#test
dbObj_count
dba.plotPCA(dbObj_count,attributes=DBA_FACTOR, label=DBA_ID)
#test ok




#dbObj_contrast <- dba.contrast(dbObj_count, contrast=c("Condition","Responsive","Resistant"))
#dbObj_contrast 
#dbObj_analyze <- dba.analyze(dbObj_contrast)
#dba.show(dbObj_analyze,bContrasts=TRUE)

dbObj_contrast <- dba.contrast(dbObj_count, categories=DBA_FACTOR, minMembers = 2)
dbObj_analyze <- dba.analyze(dbObj_contrast, method=DBA_ALL_METHODS)

res_deseq <- dba.report(dbObj_analyze, method=DBA_DESEQ2, contrast = 1, th=1)

#dba.show(dbObj_contrast, bContrasts=TRUE)
#plot(dbObj_analyze)
#hmap <- colorRampPalette(c("red", "black", "green"))(n = 13)
#dba.plotHeatmap(dbObj_contrast, contrast=1, correlations=FALSE, scale="row", colScheme = hmap)
out <- as.data.frame(res_deseq)
write.table(out, file="result.csv", sep="\t", quote=F, row.names=F)
