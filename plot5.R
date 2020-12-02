fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile="air.zip", method="curl")

unzip(zipfile="air.zip")

NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_Code.rds")

library(ggplot2)

data_sector <- SCC[grepl("mobile",SCC$EI.Sector, ignore.case=TRUE),]
scc_list <- data_sector[grep("vehicle",data_sector$SCC.Level.Two, ignore.case=TRUE),]

filteredSCC <- SCC[scc_list$SCC,]$SCC
filteredNEI <- NEI[NEI$SCC %in% filteredSCC,]
filteredNEI$year <- as.factor(filteredNEI$year)
baltimore <- subset(filteredNEI, fips=="24510")
aggregatedSumYearV <- aggregate(Emissions~year, data=filteredNEI, FUN=sum)

png("plot5.png")
ggplot(data=aggregatedSumYearV, aes(y=Emissions, x=year)) + 
  geom_bar(stat="identity") +
  ggtitle("Total PM2.5 Emissions in Baltimore City, MD From 1999-2008 By Motor Vehicles") +
  labs(x = "Year", y = "Total PM2.5 Emissions")
dev.off()