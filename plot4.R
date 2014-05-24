#Use ggplot2
library(ggplot2)

#Read Emissions Date
NEI <- readRDS("summarySCC_PM25.rds")

#Read classification table
SCC <- readRDS("Source_Classification_Code.rds")

#Filter SCC data that contains "coal" or "lignite" in the Level Three name
#This is the best match for finding coal combustion related sources
coalSCC <- SCC[grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) | 
               grepl("Lignite", SCC$SCC.Level.Three, ignore.case=TRUE),1]

#Filter NEI to only show data that match ID codes in coalSCC
coalNEI <- subset(NEI, as.numeric(SCC) %in% coalSCC)

#Aggregate data by year
agg <- aggregate(list(Emissions=coalNEI$Emissions),list(Year=coalNEI$year), sum)

#Plot data in a line graph
png(filename="plot4.png",  width = 480, height = 480)
plot(agg$Year,
     agg$Emissions,
     yaxt="n", 
     ylim=c(300000,650000),
     main="Emissions from coal combustion-related sources in the US",
     xlab="Year",
     ylab="Total Emissions (thousand tons)",
     type="b")
axis(2,at=c(3e5,3.5e5,4e5,4.5e5,5e5,5.5e5,6e5,6.5e5), 
     labels=c(300,350,400,450,500,550,600,650))
dev.off()