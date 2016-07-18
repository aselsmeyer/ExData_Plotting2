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

# Total Emissions by Year and Type
totalEmissionsByYearTypeBaltimore <- aggregate(Emissions ~ year + type, NEI[NEI$fips == "24510",], sum)


png("plot3.png", width = 640, height = 480)

#Set up ggplot with data frame

g <- ggplot(totalEmissionsByYearTypeBaltimore, aes(year, Emissions, color = type))

p3 <- g + geom_line() + 
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*' Emissions')) +
        ggtitle('Total Emissions in Baltimore City, MD from 1999 to 2008 by Type')
print(p3)

dev.off()
