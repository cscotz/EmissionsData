#Use ggplot2
library(ggplot2)

# Read Emissions Date
NEI <- readRDS("summarySCC_PM25.rds")

#Filter data for Baltimore County Maryland (fips == 24510)
NEI_BCM_ROAD <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]

#Aggregate data by year
agg <- aggregate(list(Emissions=NEI_BCM_ROAD$Emissions),list(Year=NEI_BCM_ROAD$year), sum)

#Plot line graph of emissions by year, faceted by type
p <- qplot(Year,
           Emissions,
           data=agg,
           main="Motor vehicle emissions for Baltimore County, Maryland",
           geom="line")

#save png
ggsave(p,file="plot5.png",width=6,height=4,dpi=200)