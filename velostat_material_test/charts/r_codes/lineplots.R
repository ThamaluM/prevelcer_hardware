library(ggplot2)
library(reshape2)

# data loading and preparing
#dataset = read.csv('deadweights/FR1deadweightasc.csv',fileEncoding="UTF-8-BOM")
#dataset = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")
dataset <- read.csv('deadweights/FR2deadweightasc.csv',fileEncoding="UTF-8-BOM")
#print(dataset)
melted <- melt(dataset,id=c('Weight'))

# chart


output<-ggplot(dataset)+geom_line(color='red',aes(Weight,X0s))+geom_line(color='blue',aes(Weight,X120s))
png("charts/FR2asc_line.png")
print(output)
dev.off()

pdf("charts/FR2asc_line.pdf")
print(output)
dev.off()
