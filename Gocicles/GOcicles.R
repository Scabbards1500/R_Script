if(!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("clusterProfiler") 
BiocManager::install("topGO") 
BiocManager::install("Rgraphviz") 
BiocManager::install("pathview") 
BiocManager::install("org.Mm.eg.db") 
BiocManager::install("org.Hs.eg.db") 
install.packages("ggplot2")

library(clusterProfiler)
library(topGO)
library(Rgraphviz)
library(pathview)
library(org.Mm.eg.db)
library(ggplot2)

setwd("D:\\R_Bio\\rscript\\temp")
data  = read.csv(file = "Hepatocyte_up.csv", sep = ",",header = T)

#富集分析部分
#vector = abs(data$logFC) > 0.5 & data$Gene.Name != ""
vector = data$Gene.Name != ""

data_sgni = data[vector,] 


entrez_id_full = mapIds(x = org.Mm.eg.db,
                        keys = data_sgni$Gene.Name,
                        keytype = "SYMBOL",
                        column = "ENTREZID")
head(entrez_id_full)
entrez_id = na.omit(entrez_id_full)
ENTREZID = data.frame(entrez_id)

#此处看分到几级
ggo <- groupGO(gene     = entrez_id,
               OrgDb    = org.Mm.eg.db,
               ont      = "BP",
               level    = 5,
               readable = TRUE)
write.csv(ggo,"hepatocyte_go.csv")



#MF,CC,BP
enrich.go.all = enrichGO(gene = entrez_id,
                         OrgDb = org.Mm.eg.db,
                         keyType = "ENTREZID",
                         ont = "ALL",
                         pvalueCutoff = 0.05,
                         qvalueCutoff = 0.05,
                         readable = T)
go = data.frame(enrich.go.all)
write.csv(go,"hepatocyte_go.csv")


#从这里开始就是画图了
GO_MF = go[go$ONTOLOGY=="MF",][c(1:20),]
GO_CC = go[go$ONTOLOGY=="CC",][c(1:20),]
GO_BP = go[go$ONTOLOGY=="BP",][c(1:20),]



#MF
ev = function(x){eval(parse(text = x))}
GO_MF$generatio = round(sapply(GO_MF$GeneRatio,ev),3)


shorten_names = function(x, n_word=4, n_char=100) {
  if (nchar(x) > 100) {
    if (nchar(x) > 100) x = substr(x, 1, 100)
    x = paste(paste(strsplit(x, " ")[[1]][1:min(length(strsplit(x," ")[[1]]), n_word)],
                    collapse=" "), "...", sep="")
    return(x)
  } 
  else {
    return(x)
  }
}

GO_MF$Description = sapply(GO_MF$Description,shorten_names)

ggplot(GO_MF,aes(x=generatio,y=Description,color=-1*log10(qvalue))) +
  geom_point(aes(size=Count))  + ylim(rev(GO_MF$Description)) + theme_test() +
  labs(size="Genecounts",x="GeneRatio",y="Pathway name",title="GO_MF") +
  scale_color_gradient(low="blue",high ="red") +
  theme(axis.text=element_text(size=10,color="black"),
        axis.title = element_text(size=16),title = element_text(size=13))

ggplot(GO_MF,aes(x = generatio,y = Description,fill=-1*log10(qvalue)))  +
  geom_bar(stat="identity",width=0.8 ) + ylim(rev(GO_MF$Description)) +
  theme_test() + scale_fill_gradient(low="blue",high ="red") +
  labs(size="Genecounts",x="GeneRatio",y="Pathway name",title="GO_MF") +
  theme(axis.text=element_text(size=10,color="black"),
        axis.title = element_text(size=16),title = element_text(size=13))

#CC
ev = function(x){eval(parse(text = x))}
GO_CC$generatio = round(sapply(GO_CC$GeneRatio,ev),3)


shorten_names = function(x, n_word=4, n_char=100) {
  if (nchar(x) > 100) {
    if (nchar(x) > 100) x = substr(x, 1, 100)
    x = paste(paste(strsplit(x, " ")[[1]][1:min(length(strsplit(x," ")[[1]]), n_word)],
                    collapse=" "), "...", sep="")
    return(x)
  } 
  else {
    return(x)
  }
}

GO_CC$Description = sapply(GO_CC$Description,shorten_names)

ggplot(GO_CC,aes(x=generatio,y=Description,color=-1*log10(qvalue))) +
  geom_point(aes(size=Count))  + ylim(rev(GO_CC$Description)) + theme_test() +
  labs(size="Genecounts",x="GeneRatio",y="Pathway name",title="GO_CC") +
  scale_color_gradient(low="blue",high ="red") +
  theme(axis.text=element_text(size=10,color="black"),
        axis.title = element_text(size=16),title = element_text(size=13))

ggplot(GO_CC,aes(x = generatio,y = Description,fill=-1*log10(qvalue)))  +
  geom_bar(stat="identity",width=0.8 ) + ylim(rev(GO_CC$Description)) +
  theme_test() + scale_fill_gradient(low="blue",high ="red") +
  labs(size="Genecounts",x="GeneRatio",y="Pathway name",title="GO_CC") +
  theme(axis.text=element_text(size=10,color="black"),
        axis.title = element_text(size=16),title = element_text(size=13))


#BP
ev = function(x){eval(parse(text = x))}
GO_BP$generatio = round(sapply(GO_BP$GeneRatio,ev),3)


shorten_names = function(x, n_word=4, n_char=100) {
  if (nchar(x) > 100) {
    if (nchar(x) > 100) x = substr(x, 1, 100)
    x = paste(paste(strsplit(x, " ")[[1]][1:min(length(strsplit(x," ")[[1]]), n_word)],
                    collapse=" "), "...", sep="")
    return(x)
  } 
  else {
    return(x)
  }
}

GO_BP$Description = sapply(GO_BP$Description,shorten_names)

ggplot(GO_BP,aes(x=generatio,y=Description,color=-1*log10(qvalue))) +
  geom_point(aes(size=Count))  + ylim(rev(GO_BP$Description)) + theme_test() +
  labs(size="Genecounts",x="GeneRatio",y="Pathway name",title="GO_BP") +
  scale_color_gradient(low="blue",high ="red") +
  theme(axis.text=element_text(size=10,color="black"),
        axis.title = element_text(size=16),title = element_text(size=13))

ggplot(GO_BP,aes(x = generatio,y = Description,fill=-1*log10(qvalue)))  +
  geom_bar(stat="identity",width=0.8 ) + ylim(rev(GO_BP$Description)) +
  theme_test() + scale_fill_gradient(low="blue",high ="red") +
  labs(size="Genecounts",x="GeneRatio",y="Pathway name",title="GO_BP") +
  theme(axis.text=element_text(size=10,color="black"),
        axis.title = element_text(size=16),title = element_text(size=13))


