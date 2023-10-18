#更新r
install.packages("installr")
library(installr)
updateR()


BiocManager::install("mediation") 
library(mediation)
#导入文件
bc<-read.csv("D:/R_Bio/tempdata/Mediationdata.csv",sep=',',header=TRUE)


#焦虑和治疗的方程，因为焦虑指标为连续的，这里使用lm连接
# med.fit <- lm(emo ~ treat , data = bc)
med.fit <- lm(M1 ~ X1 , data = bc)


#然后建立结局变量，中介变量和自变量关系方程
out.fit <- glm(Y1 ~ M1, data = bc)


#行中介效应分析，treat填自变量，mediator填中介变量，robustSE为显示可信区间，sims为重复100次，也可以自己调整

med.out <- mediate(med.fit, out.fit, treat = "X1", mediator = "M1",
                   robustSE = TRUE, sims = 100)###treat填自变量，mediator填中介变量

#解析结果
summary(med.out)


#绘图
plot(med.out)

#接下来我们进一步做敏感性分析
sens.out <- medsens(med.out, rho.by = 0.1, effect.type = "indirect", sims = 100)
summary(sens.out)


#Y表示中介效应值，X表示敏感度关于rho。虚线表示rho=0的时候，就是没有混杂效应的时候。红线表示混杂效应导致中介效应消失时rho的值（有点拗口，自己体会一下），因此得出rho的绝对值越高，中介效应越可靠。
#我们还可以做出R方的图，R方的解释与其他模型R方的解释是一样的。

plot(sens.out, sens.par = "R2", r.type = "total", sign.prod = "positive")



