library(ggplot2)
library(reshape2)

# data loading and preparing
dataset = read.csv('deadweights/FR1deadweightasc.csv',fileEncoding="UTF-8-BOM")
#dataset = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")
#dataset <- read.csv('deadweights/FR2deadweightasc.csv',fileEncoding="UTF-8-BOM")

colnames(dataset) = c('Weight',0,15,30,45,60,75,90,105,120)

#print(dataset)
melted <- melt(dataset,id=c('Weight'))
print(melted)

# chart


output<-ggplot(melted)+geom_point()+geom_line()+aes(variable,value,color=factor(Weight))+aes(group=Weight)
output <- output + labs(title=" Time - Resistance(1 layer of 1' \u00d7 1' Velostat)",x='Time(s)', y = "Resistance (\u03a9)", color = "Force(gf)")
#png("charts/FR1asc_timeline.png")
print(output)
#ggsave("charts/to_presentation/FR1timeline.png", plot = output, width = 5, dpi = 300, units = "in")
#dev.off()

#pdf("charts/to_presentation/FR1asc_timeline.pdf")
#print(output)
#dev.off()
