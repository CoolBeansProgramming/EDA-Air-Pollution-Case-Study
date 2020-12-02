# download file and unzip file 
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile="air.zip", method="curl")

unzip(zipfile="air.zip")

NEI <-readRDS("summarySCC_PM25.rds")
SCC <-readRDS("Source_Classification_Code.rds")

library(ggplot2)

# subset emissions data for Balitmore only
baltimore <-NEI[NEI$fips=="24510", ]

# create plot 
png('plot3.png')
g<-ggplot(aes(x = factor(year), y = Emissions, fill=type), data=baltimore)
g+geom_bar(stat="identity")+
  facet_grid(.~type)+
  labs(x="Year", y=expression("Total PM2.5 Emissions")) + 
  labs(title=expression("Total PM2.5 Emissions in Baltimore City,MD from 1999-2008 by Source"))+
  guides(fill=FALSE)
dev.off()


