# download file and unzip file 
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile="air.zip", method="curl")

unzip(zipfile="air.zip")

NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_Code.rds")

library(ggplot2)

# indicies coal combustion-related sources and subset NEI 
coal  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coalSubset <-NEI[coal,]

# calculate total emission for each year
aggregatedSumYearC <- aggregate(Emissions~year, data=coalSubset, FUN=sum)

# create plot
png('plot4.png')
g <-ggplot(aggregatedSumYearC, aes(x=factor(year), y=Emissions))
g + geom_bar(stat="identity") +
  labs(x="Year", y=expression("Total PM2.5 Emissions")) +
  ggtitle("Total PM2.5 Emissions from Coal Combustion-Related Sources From 1999-2008") +
  guides(fill=FALSE)
dev.off()

