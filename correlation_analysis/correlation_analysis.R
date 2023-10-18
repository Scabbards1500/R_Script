
setwd("D:/R_Bio/rscript/correlation_analysis/data")


#读取数据
data<-read.csv("data.csv",sep=',',header=TRUE)

#C-AP列（PSQI1-BACS7）为临床变量
#ReHo1- ReHo5(没有ReHo2)4个变量为第一个脑影像变量
#ALFF1- ALFF9为第二个脑影像变量组
#FC1-FC7为第三个脑影像变量组

#X1为C-AP列（PSQI1-BACS7）为临床变量
X1 = data[3:42]

#Y1 ReHo1- ReHo5(没有ReHo2)4个变量为第一个脑影像变量
Y1 = data[43:46]

#Y2 ALFF1- ALFF9为第二个脑影像变量组
Y2 = data[47:55]

#Y3 FC1-FC7为第三个脑影像变量组
Y3 = data[55:62]

#进行一个归一化操作
test<-data.frame(X1,Y1)
#test<-data.frame(X1,Y2)
#test<-data.frame(X1,Y3)
#test<-data.frame(X1,Y1,Y2,Y3)
test<-scale(test)

ca<-cancor(test[,1:40],test[,41:44])  #x1y1
#这里视y个数调整

#实验结果
#cor给出了典型相关系数
cor <- ca$cor
#xcoef是对应于数据X的系数, 即为关于数据X的典型载荷; 
xcoef <- ca$xcoef
#ycoef为关于数据Y的典型载荷;
ycoef <- ca$ycoef
#xcenter与$ycenter是数据X与Y的中心, 即样本均值;
xcenter <-ca$xcenter
ycenter <-ca$ycenter


# 
# #相关系数检验R程序
# corcoef.test<-function(r, n, p, q, alpha=0.1){
#   #r为相关系数 n为样本个数 且n>p+q
#   m<-length(r); Q<-rep(0, m); lambda <- 1
#   for (k in m:1){
#     #检验统计量 
#     lambda<-lambda*(1-r[k]^2); 
#     #检验统计量取对数
#     Q[k]<- -log(lambda)  
#   }
#   s<-0; i<-m 
#   for (k in 1:m){
#     #统计量  
#     Q[k]<- (n-k+1-1/2*(p+q+3)+s)*Q[k]
#     chi<-1-pchisq(Q[k], (p-k+1)*(q-k+1))
#     if (chi>alpha){
#       i<-k-1; break
#     }
#   }
#   #显示输出结果 选用第几对典型变量
#   i
# }
# 
# 
# #输入相关系数r，样本个数n，两个随机向量的维数p和q，置信水平a（缺省值为0.1）
# corcoef.test(r=ca$cor,n=68,p=40,q=21)
# #程序输出值为典型变量的对数

write.csv(xcoef,"x1y1xcoef.csv")

  