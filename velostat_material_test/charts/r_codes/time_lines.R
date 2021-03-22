library(ggplot2)
library(reshape2)

# data loading and preparing
#dataset = read.csv('deadweights/FR1deadweightasc.csv',fileEncoding="UTF-8-BOM")
#dataset = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")
dataset <- read.csv('deadweights/FR2deadweightasc.csv',fileEncoding="UTF-8-BOM")

colnames(dataset) = c('Weight',0,15,30,45,60,75,90,105,120)

#print(dataset)
melted <- melt(dataset,id=c('Weight'))
print(melted)

# chart


output<-ggplot(melted)+geom_line()+aes(variable,value,color=factor(Weight))+aes(group=Weight)

png("charts/FR2asc_timeline.png")
print(output)
dev.off()

pdf("charts/FR2asc_timeline.pdf")
print(output)
dev.off()
