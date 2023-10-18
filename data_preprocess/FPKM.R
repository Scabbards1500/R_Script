setwd("F:\\R_Bio\\FPKM\\220727HY")
fileKO<-read.csv("KO_M_overlaps.csv")
total=117458208
fileKO$length <- abs(fileKO$X3513955-fileKO$X3514657)
fileKO$FPKM <-total/(fileKO$X165*fileKO$length)
fileKO$length<-NULL

fileWT<-read.csv("WT_M_overlaps.csv")
total2=124711284
fileWT$length <- abs(fileWT$X3514657-fileWT$X3513955)
fileWT$FPKM <-total2/(fileWT$X286*fileWT$length)
fileWT$length<-NULL

FOLD <-fileKO$FPKM/fileWT$FPKM

MOCK<-cbind(fileWT$chr1,fileWT$X3513955,fileWT$X3514657,fileWT$X4785401,fileWT$X4786146,fileKO$FPKM,fileWT$FPKM,FOLD)
write.csv(MOCK,"MOCK.csv") 

