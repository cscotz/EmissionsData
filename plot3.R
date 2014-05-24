#Use ggplot2
library(ggplot2)

# Read Emissions Date
NEI <- readRDS("summarySCC_PM25.rds")

#Filter data for Baltimore County Maryland (fips == 24510)
NEI_BCM <- NEI[NEI$fips == "24510",]

#Aggreate emissions date by year and type
agg <- aggregate(list(Emissions=NEI_BCM$Emissions),list(Year=NEI_BCM$year, Type=NEI_BCM$type), sum)

#Plot line graph of emissions by year, faceted by type
p <- qplot(Year,
           Emissions,
           data=agg,
           facets=.~ Type,
           geom="line")

#save png
ggsave(p,file="plot3.png",width=8,height=3,dpi=200)