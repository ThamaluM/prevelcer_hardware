library(ggplot2)
library(reshape2)

# data loading and preparing
dataset = read.csv('universal_testing_machine/FR1ascUTM.csv',fileEncoding="UTF-8-BOM")
dataset2 = read.csv('universal_testing_machine/FR1descUTM.csv',fileEncoding="UTF-8-BOM")
#print(dataset)
#melted <- melt(dataset,id=c('Weight'))

# chart


output<-ggplot()+ geom_point(dataset,color='blue',mapping=aes(Initial.Weight,Initial.Resistance))
output <- output + geom_point(dataset,color='blue',mapping=aes(Stabilized.Weight,Stabilized.Resistance))
output <- output + geom_smooth(dataset,color='blue',mapping=aes(Stabilized.Weight,Stabilized.Resistance))
output <- output + geom_point(dataset2,color='blue',mapping=aes(Stabilized.Weight,Stabilized.Resistance))
output <- output + xlab("Force (gf)") + ylab("Resistance (\u03a9)") + ggtitle("Force - Resistance  (1 layer of 1' \u00d7 1' Velostat)")


#png("charts/to_presentation/FR1asc_line_UTM.png")
print(output)
#dev.off()

pdf("charts/to_presentation/FR1asc_line_UTM.pdf")
print(output)
dev.off()
