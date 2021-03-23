library(ggplot2)
library(reshape2)

# data loading and preparing
#dataset = read.csv('deadweights/FR1deadweightasc.csv',fileEncoding="UTF-8-BOM")
dataset = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")
#dataset <- read.csv('deadweights/FR2deadweightasc.csv',fileEncoding="UTF-8-BOM")
#print(dataset)
melted <- melt(dataset,id=c('Weight'))

# chart


output<-ggplot(dataset)+geom_smooth(color='blue',aes(Weight,X120s))+ylab("Stabilized Reading (120s)")
png("charts/FR1desc_line_smooth.png")
print(output)
dev.off()

pdf("charts/FR1desc_line_smooth.pdf")
print(output)
dev.off()
