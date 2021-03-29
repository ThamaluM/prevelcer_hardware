library(ggplot2)
library(reshape2)

# data loading and preparing
dataset_asc = read.csv('deadweights/FR2deadweightasc.csv',fileEncoding="UTF-8-BOM")
dataset_desc = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")

dataset = rbind(dataset_asc,dataset_desc)
#print(dataset)
#melted <- melt(dataset,id=c('Weight'))

# chart



#colors <- c("Ascending Force"='dark green',"Descending Force"='orange')

output <- ggplot(dataset) + geom_smooth(x=Weight,y=X120s)+geom_point(x=Weight,y=X120s)
#output<-ggplot()+geom_line(data=dataset_asc,aes(x=Weight,y=X120s,color='Ascending Force'))+geom_point(data=dataset_asc,aes(x=Weight,y=X120s,color='Ascending Force'))
#output <- output +labs(title = "Force - Resistance  (2 layers of 1' \u00d7 1' velostat)",x="Force (gf)",y="Resistance (\u03a9)") 
#output <- output + scale_x_continuous(breaks=c(0,250,500,750,1000,1250))

pdf("charts/to_presentation/final_line.pdf")
print(output)
dev.off()

#png("charts/to_presentation/final_line.png")
print(output)
#dev.off()



ggsave("charts/to_presentation/final_line.png", plot = output, width = 5, dpi = 300, 
       units = "in")