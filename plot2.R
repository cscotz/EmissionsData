# Read Emissions Date
NEI <- readRDS("summarySCC_PM25.rds")

#Filter data for Baltimore County Maryland (fips == 24510)
NEI_BCM <- NEI[NEI$fips == "24510",]

#Aggregate data by year
agg <- tapply(NEI_BCM$Emissions,NEI_BCM$year,sum)

#Plot data in a boxplot
png(filename="plot2.png",  width = 480, height = 480)
barplot(agg, 
        yaxt="n", 
        ylim=c(0,3500),
        col=rainbow(4),
        main="Emissions in Baltimore County, Maryland",
        xlab="Year",
        ylab="Total Emissions (hundred tons)")
axis(2,at=c(0,5e2,10e2,15e2,20e2,25e2,30e2,35e2), 
       labels=c(0,5,10,15,20,25,30,35))
dev.off()