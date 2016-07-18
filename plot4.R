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

# Grab any records matching "coal" in the SCC Short.Name
coal <- grepl("coal", mergeNEISCC$Short.Name, ignore.case = TRUE)

coalNEISCC <- mergeNEISCC[coal,]

totalEmissionsByYearCoal <- aggregate(Emissions ~ year, coalNEISCC, sum)

# Create png file
png("plot4.png", width = 640, height = 480)

# Create plot

g <- ggplot(totalEmissionsByYearCoal, aes(factor(year), Emissions))

p4 <- g + geom_bar(stat = "identity") +
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*' Emissions')) +
        ggtitle("Total Emissions From Coal Sources (1999 - 2008)")

# Print plot

print(p4)

dev.off()