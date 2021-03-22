library(ggplot2)
library(reshape2)

# data loading and preparing
#dataset = read.csv('deadweights/FR1deadweightasc.csv',fileEncoding="UTF-8-BOM")
dataset = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")
#dataset <- read.csv('deadweights/FR2deadweightasc.csv',fileEncoding="UTF-8-BOM")
#print(dataset)
melted <- melt(dataset,id=c('Weight'))

# chart


output<-ggplot(melted)+geom_boxplot()+aes(Weight,value)+aes(group=Weight)

png("charts/FR1desc_box.png")
print(output)
dev.off()

pdf("charts/FR1desc_box.pdf")
print(output)
dev.off()
