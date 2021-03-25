library(ggplot2)
library(reshape2)

# data loading and preparing
dataset_asc = read.csv('deadweights/FR2deadweightasc.csv',fileEncoding="UTF-8-BOM")
#dataset_desc = read.csv('deadweights/FR1deadweightdesc.csv',fileEncoding="UTF-8-BOM")
#print(dataset)
#melted <- melt(dataset,id=c('Weight'))

# chart

colors <- c("Ascending Force"='dark green',"Descending Force"='orange')


output<-ggplot()+geom_line(data=dataset_asc,aes(x=Weight,y=X120s,color='Ascending Force'))+geom_point(data=dataset_asc,aes(x=Weight,y=X120s,color='Ascending Force'))#+geom_line(data=dataset_desc,aes(x=Weight,y=X120s,color='Descending Force'))+geom_point(data=dataset_desc,aes(x=Weight,y=X120s,color='Descending Force'))

output <- output +labs(title = "Force - Resistance  (2 layers of 1' \u00d7 1' velostat)",x="Force (gf)",y="Resistance (\u03a9)",color="Legend") + scale_color_manual(values=colors)
output <- output + scale_x_continuous(breaks=c(0,250,500,750,1000,1250))

pdf("charts/to_presentation/FR2asc_desc_line.pdf")
print(output)
dev.off()

#png("charts/to_presentation/FR2asc_desc_line.png")
print(output)
#dev.off()



ggsave("charts/to_presentation/FR2asc_desc_line.png", plot = output, width = 5, dpi = 300, 
       units = "in")