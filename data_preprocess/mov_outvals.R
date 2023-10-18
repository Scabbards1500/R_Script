mdtestdata<-read.csv("D:/R_Bio/tempdata/Mediationdata.csv",sep=',',header=TRUE)
setwd("D:/R_Bio/tempdata")


count = 1
for (i in 1:13) {

    }

x = mdtestdata$M2
OutVals = boxplot(x)$out
print(OutVals)
x[x %in% boxplot(x)$out] <- NA
print(x)



mdtestdata$M2 =x

write.csv(mdtestdata,"mdtestdatana.csv")
count = count+1