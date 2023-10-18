
library(mediation)
#导入文件



# 获取所有result
count=1
for (i in 1:6) {
  for(j in 7:11){
    for(k in 12:13){

    #   if(count==31){
    #     print(i)
    #     print(j)
    #     print(k)
    #   }
    #   count = count+1
    # }}}

      
      Y = mdtestdata[i]
      X = mdtestdata[j]
      M = mdtestdata[k]
      
      # #取出偏离值
      # listtemp = cbind(Y=Y,X=X,M=M)
      # listtemp = na.omit(listtemp)
      # 
      # Y = listtemp$Y
      # X = listtemp$X
      # M = listtemp$M
      
      Y = unlist(Y)
      X = unlist(X)
      M = unlist(M)
      


      #第 1 步：总效应量
      fit.totaleffect=lm(Y~X)
      #summary(fit.totaleffect)
      
      #第 2 步：自变量对中介者的影响
      fit.mediator=lm(M~X)
      #summary(fit.mediator)
      
      #第 3 步：中介者对因变量的影响
      fit.Y=lm(Y~X+M)
      #summary(fit.Y)
      
      #第 4 步：因果中介分析
      results = mediate(fit.mediator, fit.Y, treat='X', mediator='M', boot=T)
      assign(paste("result",count,sep = ""),results)
      print(count)
      count = count+1
    
    }
  }
}


#筛选合适值
for(i in 1:60){
  tmp = get(paste("result",i,sep = ""))
  if (tmp$d0.p <0.2){
    print(paste("result",i,sep = ""))
    print(tmp$d0.p)
  }
}
for(i in 1:60){
  tmp = get(paste("result",i,sep = ""))
  if (tmp$n0.p <0.2){
    print(paste("result",i,sep = ""))
    print(tmp$n0.p)
  }
}

summary(result31)

set.seed(12334)
mdtestdata<-read.csv("D:/R_Bio/tempdata/Mediationdata.csv",sep=',',header=TRUE)
#对result31组合的变量abc进行分析
#第 1 步：总效应量
fit.totaleffect=lm(Y4~X1,mdtestdata)
#summary(fit.totaleffect)

#第 2 步：自变量对中介者的影响
fit.mediator=lm(M1~X1,mdtestdata)
#summary(fit.mediator)

#第 3 步：中介者对因变量的影响
fit.Y4=lm(Y4~X1+M1,mdtestdata)
#summary(fit.Y4)
#第 4 步：因果中介分析
results = mediate(fit.mediator, fit.Y4, treat='X1', mediator='M1', boot=T)
summary(results)
