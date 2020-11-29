# download file and unzip file 
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile="air.zip", method="curl")

unzip(zipfile="air.zip")

NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_Code.rds")

# calculate total emission for each year
aggregatedSumYear <- aggregate(Emissions~year, data=NEI, FUN=sum)

# create plot 
png('plot1.png')
barplot(height = aggregatedSumYear$Emissions, names.arg=aggregatedSumYear$year, xlab="Year", ylab="Total PM2.5 Emissions", main="Total PM2.5 emissions from 1999-2008")
dev.off()