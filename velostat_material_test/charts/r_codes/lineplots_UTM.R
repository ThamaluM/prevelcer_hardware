library(ggplot2)
library(reshape2)

# data loading and preparing
dataset = read.csv('universal_testing_machine/FR1ascUTM.csv',fileEncoding="UTF-8-BOM")
#dataset = read.csv('deadweights/FR1descUTM.csv',fileEncoding="UTF-8-BOM")
#print(dataset)
#melted <- melt(dataset,id=c('Weight'))

# chart


output<-ggplot(dataset)+ geom_point(color='red',aes(Initial.Weight,Initial.Resistance))
output <- output + geom_point(color='blue',aes(Stabilized.Weight,Stabilized.Resistance))
output <- output + geom_smooth(color='blue',aes(Stabilized.Weight,Stabilized.Resistance))
output <- output + xlab("Weight") + ylab("Resistance")
png("charts/FR1asc_line_UTM.png")
print(output)
dev.off()

pdf("charts/FR1asc_line_UTM.pdf")
print(output)
dev.off()
