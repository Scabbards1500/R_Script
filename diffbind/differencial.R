BiocManager::install("DiffBind") 
library(DiffBind)
setwd(system.file('extra',package='DiffBind'))
getwd()

tmpdir <- tempdir()
url <- 'https://content.cruk.cam.ac.uk/bioinformatics/software/DiffBind/DiffBind_vignette_data.tar.gz'
file <- basename(url)
options(timeout=600)
download.file(url, file.path(tmpdir,file))

untar(file.path(tmpdir,file), exdir = tmpdir )
setwd(file.path(tmpdir,"DiffBind_Vignette"))
getwd()
tamoxifen <- dba.analyze("tamoxifen.csv")
tamoxifen.DB <- dba.report(tamoxifen)

tamoxifen <- dba(sampleSheet="tamoxifen.csv")
dba.blacklist(tamoxifen) 
dba.count(tamoxifen) 
dba.normalize(tamoxifen) 
samples <- read.csv(file.path(system.file("extra", package="DiffBind"),"tamoxifen.csv"))
tamoxifen <- dba(sampleSheet="tamoxifen.csv",dir=system.file("extra", package="DiffBind"))
tamoxifen <- dba(sampleSheet=samples)


data(tamoxifen_peaks)
plot(tamoxifen)
dba.plotHeatmap(tamoxifen)

#3.2(必要的)
tamoxifen <- dba.count(tamoxifen)

#3.4(可以不要)
tamoxifen<-dba.normalize(tamoxifen)

#3.5（必要的）
tamoxifen_contrast <- dba.contrast(tamoxifen,reorderMeta=list(Condition="Responsive"))

#3.6
tamoxifen <- dba.analyze(tamoxifen)
dba.show(tamoxifen, bContrasts=TRUE)
plot(tamoxifen,contrast=1)
dba.plotHeatmap(tamoxifen,contrast = 1)

#4.6
corvals <- dba.plotHeatmap(tamoxifen)
hmap <- colorRampPalette(c("red", "black", "green"))(n = 13)
readscores <- dba.plotHeatmap(tamoxifen, contrast=1, correlations=FALSE, scale="row", colScheme = hmap)



#sample2<-read.csv("D:\\R_Bio\\differencial\\diffbind.csv")
#data <- dba(sampleSheet="D:\\R_Bio\\differencial\\diffbind.csv")
#data<-dba(sampleSheet = sample2)
