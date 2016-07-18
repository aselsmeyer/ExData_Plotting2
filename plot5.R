setInternet2(TRUE)
library(ggplot2)
options('download.file.method' = 'curl')

#Download the data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(URL, destfile = "./NEI_data.zip", method = "auto")

dateDownloaded <- date()

#Unzip the file
unzip("./NEI_data.zip", exdir = ".")

# Read in the datasets
if(!exists("NEI")){
NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
SCC <- readRDS("Source_Classification_Code.rds")
}

# Merge datasets
if(!exists("mergeNEISCC")) {
        mergeNEISCC <- merge(NEI, SCC, by = "SCC")
}

totalEmissionsByYear <- aggregate(Emissions ~ year, NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",], sum)

# Create png file
png("plot5.png", width = 840, height = 480)

g <- ggplot(totalEmissionsByYear, aes(factor(year), Emissions))

p5 <- g + geom_bar(stat = "identity") +
        xlab("Year") + 
        ylab(expression('Total PM'[2.5]*' Emissions')) +
        ggtitle('Total Emissions From Motor Vehicle Sources in Baltimore City, MD (1999-2008)')

# Print plot
print(p4)

dev.off()