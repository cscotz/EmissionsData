#Use ggplot2
library(ggplot2)

#Read Emissions Date
NEI <- readRDS("summarySCC_PM25.rds")

#Filter data for Los Angeles County, California (fips == 06037)
NEI_LAC <- NEI[NEI$fips=="06037" & NEI$type=="ON-ROAD",]

#Filter data for Baltimore County Maryland (fips == 24510)
NEI_BCM <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]

#Aggregate data by year
aggLAC <- aggregate(list(Emissions=NEI_LAC$Emissions),list(Year=NEI_LAC$year), sum)
aggBCM <- aggregate(list(Emissions=NEI_BCM$Emissions),list(Year=NEI_BCM$year), sum)

#Calculate percentage change since 1999 for each data point
aggLACp <- with(aggLAC, Emissions/Emissions[Year==1999]-1)*100
aggBCMp <- with(aggBCM, Emissions/Emissions[Year==1999]-1)*100

#Combine aggregated data
combined <- data.frame(aggLAC$Year, aggLACp, aggBCMp)
colnames(combined) <- c("Year","LAC","BCM")

png(filename="plot6.png",  width = 480, height = 480)
with(combined, {
     plot(Year,
          LAC, 
          type="b",
          lwd=3,
          col="red",
          ylim=c(-75,25),
          main="Motor Vehicle Emissions in Baltimore and Los Angeles Counties\nChart shows cumulative percentage change since 1999",
          ylab="Cumulative emissions change since 1999 (%)", 
          xlab="Year")
     lines(Year,
           BCM,
           lwd=3,
           type="b",
           col="blue")
     legend("topright", 
            legend=c("Los Angeles","Baltimore"), 
            col=c("red","blue"),
            cex=0.9,
            lty=1)
})
dev.off()