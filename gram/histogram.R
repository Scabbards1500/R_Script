library(ggplot2)
library(reshape2)

data<-read.csv("D:/R_Bio/tempdata/xzx2.csv",sep=',',header=TRUE)


#1
dfm = melt(data, id.vars=c("OPTIONS"), measure.vars=c("X1st","X2nd","X3th","X4th"),
           variable.name="options", value.name="frequency")

#dfm$OPTIONS= factor(dfm$OPTIONS, levels = data$OPTIONS)


ggplot(dfm, aes(x = OPTIONS, y = frequency, options = options)) + 
  ggtitle("RANKING OF REPRESENTATION PREFERENCE")+
  geom_col(aes(fill=options)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.25)) +
  geom_text(aes(label = frequency), position = position_stack(vjust = .5), size = 3)  # labels inside the bar segments



#2
dfm = melt(data, id.vars=c("OPTIONS"), measure.vars=c("SYNTHESIS.SCORE"),
           variable.name="options", value.name="synthesis_score")

#dfm$OPTIONS= factor(dfm$OPTIONS, levels = data$OPTIONS)


ggplot(dfm, aes(x = OPTIONS, y = synthesis_score, options = options)) + 
  ggtitle("RANKING OF REPRESENTATION PREFERENCE")+
  geom_col(aes(color=options  , fill=options)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.25)) +
  geom_text(aes(label = synthesis_score), position = position_stack(vjust = .5), size = 3)  # labels inside the bar segments



