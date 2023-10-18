BiocManager::install("TxDb.Mmusculus.UCSC.mm10.knownGene")
library(goseq)

setwd("F:\\R_Bio\\GO\\220804HY")
data  = read.csv(file = "hepatocyte.csv", sep = ",",header = T)



gene=data$Nearest.Ensembl !=""
gene = data[gene,] 
gene =gene$Nearest.Ensembl


A<-rep(1,length(gene))
A<-as.integer(A)
names(A)=gene

#eg
data(genes)
pwf=nullp(genes,"hg19","ensGene")
GO.wall=goseq(pwf,"hg19","ensGene")
#ces

#ensGene 意为基因名称使用 ensembl id 作匹配进行富集
pvals<-getgo(gene, 'mm10','ensGene')

#通过getlength函数检索gene的长度
genelength<-getlength(names(A),'mm10','ensGene')

#使⽤nullp函数(Probability Weighting Function)计算概率加权函数
pwf <- nullp(gene, 'mm10','ensGene')


go <- goseq(pwf = pvals, id = pro_id, gene2cat = uniprotid2GO, method = "Hypergeometric", use_genes_without_cat = TRUE)