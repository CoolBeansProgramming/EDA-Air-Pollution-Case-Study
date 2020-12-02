# download file and unzip file 
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile="air.zip", method="curl")

unzip(zipfile="air.zip")

NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_Code.rds")

# subset emissions data for Balitmore only
baltimore <-NEI[NEI$fips=="24510", ]
aggSumYearBalt <-aggregate(Emissions~year, baltimore, sum)

# create plotpng('plot2.png')
barplot(height = aggSumYearBalt$Emissions, names.arg = aggSumYearBalt$year, xlab="Year", ylab="Total PM2.5 Emissions", main="Total PM2.5 Emissions in Baltimore City, MD from 1999-2008")
dev.off()

