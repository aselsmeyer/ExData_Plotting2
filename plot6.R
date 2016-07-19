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

# Subset Baltimore City and Los Angeles County data
subsetNEI <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]
subsetNEI <- subsetNEI[subsetNEI$type == "ON-ROAD",]

# Add new column defining cities
subsetNEI = within(subsetNEI, {
        city = ifelse(fips == "24510", "Baltimore City, MD", "Los Angeles County, CA")
})

# Total Emissions by Year and City
totalEmissionsByYearCity <- aggregate(Emissions ~ year + city, subsetNEI, sum)

png("plot6.png", width = 640, height = 480)

#Set up ggplot with data frame

g <- ggplot(totalEmissionsByYearCity, aes(year, Emissions, color = city))

p6 <- g + geom_line() + 
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*' Emissions')) +
        ggtitle('Total Emissions from Motor Vehicle Sources in Baltimore City, MD vs. Los Angeles County, CA from 1999 to 2008')
print(p6)

dev.off()