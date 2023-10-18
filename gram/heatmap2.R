#heatmap
setwd("D:/R_Bio/rscript/heatmap/0412data")
BiocManager::install("Hmisc")
BiocManager::update()
install.packages("devtools")
devtools::install_github("yiluheihei/pcor")


library(readr)
library(plyr)
library(readxl)
library(RColorBrewer)
library(pheatmap)
library(psych)
library(ggplot2)
library(reshape2)
library(ppcor)
library(Hmisc)


df = read.csv("141_50_CO_noCM_new8ROIs.csv",header = T,row.names = 1)
data = as.matrix(df)
pheatmap(data,cluster_row = FALSE)


# 创建数据
x <- df[5:20]
y <- df[21:32]
z <- df[1:4]

data <- cbind(x, y)

pcorr <- rcorr(as.matrix(data), type="pearson")

# 提取偏相关系数矩阵和p值矩阵
pcorr_mat <- pcorr$r
pvalue_mat <- pcorr$P

write.csv(pvalue_mat,"141_50_CO_noCM_new8ROIs_pvalue.csv")

# 绘制热图
pheatmap(pcorr_mat,cluster_row = FALSE)

# 将偏相关系数矩阵和p值矩阵转换为长格式
pcorr_melted <- reshape2::melt(pcorr_mat)
pvalue_melted <- reshape2::melt(pvalue_mat)

# 合并偏相关系数矩阵和p值矩阵的长格式数据框
merged_df <- merge(pcorr_melted, pvalue_melted, by = c("Var1", "Var2"))
names(merged_df) <- c("variable1", "variable2", "pcorr", "pvalue")

# 提取p值小于0.05的变量组合
significant_pairs <- merged_df[merged_df$pvalue < 0.05, ]

# 针对p值小于0.05的变量组合进行散点图绘制
for (i in 1:nrow(significant_pairs)) {
  x_var <- as.character(significant_pairs[i, "variable1"])
  y_var <- as.character(significant_pairs[i, "variable2"])
  plot_title <- paste("Scatter plot of", x_var, "and", y_var)
  ggplot(data=data, aes(x=x_var, y=y_var)) +
    geom_point() +
    labs(title=plot_title, x=x_var, y=y_var)
}











# 将偏相关系数矩阵和p值矩阵转换为长格式
pcorr_melted <- reshape2::melt(pcorr_mat)
pvalue_melted <- reshape2::melt(pvalue_mat)

# 合并偏相关系数矩阵和p值矩阵的长格式数据框
merged_df <- merge(pcorr_melted, pvalue_melted, by = c("Var1", "Var2"))
names(merged_df) <- c("variable1", "variable2", "pcorr", "pvalue")

# 提取p值小于0.05的变量组合
significant_pairs <- merged_df[merged_df$pvalue < 0.05, ]

# 针对p值小于0.05的变量组合进行散点图绘制
for (i in 1:nrow(significant_pairs)) {
  x_var <- as.character(significant_pairs[i, "variable1"])
  y_var <- as.character(significant_pairs[i, "variable2"])
  plot_title <- paste("Scatter plot of", x_var, "and", y_var)
  ggplot(data=data, aes(x=x_var, y=y_var)) +
    geom_point() +
    labs(title=plot_title, x=x_var, y=y_var)
}













# 计算 Pearson 相关系数
corrolation =  cor(x,y, method = "pearson")



result = pcor.test(x, y, z, method="pearson")
df <- data.frame(x=x, y=y, z=z)

# 计算偏相关系数
pcorr <- rcorr(as.matrix(df), type="pearson")$r
pcorr <- pcor.test(as.matrix(df))$estimate

# 将偏相关系数矩阵转换为长格式
melted <- melt(pcorr)
melted <- subset(melted, variable != variable.1)

# 绘制热图
ggplot(data=melted, aes(x=variable, y=variable.1, fill=value)) +
  geom_tile(color="white") +
  scale_fill_gradient(low="blue", high="red", limits=c(-1,1)) +
  theme_bw() +
  labs(title="偏相关系数热图", x="", y="")

