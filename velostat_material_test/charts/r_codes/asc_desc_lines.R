library(ggplot2)
library(reshape2)

# data loading and preparing
dataset_asc = read.csv('deadweights/FR1deadweightasc.csv',fileEncoding="UTF-8-BOM")
dataset_desc = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")
#print(dataset)
#melted <- melt(dataset,id=c('Weight'))

# chart


output<-ggplot()+geom_line(data=dataset_asc,aes(x=Weight,y=X120s),color='dark green')+geom_line(data=dataset_desc,aes(x=Weight,y=X120s),color='orange')

png("charts/FR1asc_desc_line.png")
print(output)
dev.off()

pdf("charts/FR1asc_desc_line.pdf")
print(output)
dev.off()
