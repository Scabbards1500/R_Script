
mdtestdata<-read.csv("D:/R_Bio/tempdata/mdtestdatana.csv",sep=',',header=TRUE)

Y = mdtestdata[1]
X = mdtestdata[7]
M = mdtestdata[12]

#合并列
listtemp = cbind(Y=Y,X=X,M=M)
#去除列种的NA值
listtemp = na.omit(listtemp)

#取出列
Y = listtemp$Y
X = listtemp$X
M = listtemp$M
typeof(X)
