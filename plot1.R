# Read Emissions Date
NEI <- readRDS("summarySCC_PM25.rds")

#Aggregate data by year
agg <- tapply(NEI$Emissions,NEI$year,sum)

#Plot data in a boxplot
png(filename="plot1.png",  width = 480, height = 480)
barplot(agg, 
        yaxt="n", 
        col=rainbow(4),
        xlab="Year",
        ylab="Total Emissions (million tons)")
axis(2,at=c(0,2e6,4e6,6e6,8e6), labels=c(0,2,4,6,8))
dev.off()