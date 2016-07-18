setInternet2(TRUE)
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

# aggregate emissions in Baltimore City, Maryland (fips == "24510") from 1999-2008
totalEmissionsByYearBaltimore <- aggregate(Emissions ~ year, NEI[NEI$fips == "24510",], sum)

# Create png file
barplot(height = totalEmissionsByYearBaltimore$Emissions, names.arg = totalEmissionsByYearBaltimore$year, xlab = "years", ylab = expression('Total PM'[2.5]*' Emission'), main = expression('Total PM'[2.5]*' in Baltimore City, MD by Year'))

dev.copy(png, file = "plot2.png")
dev.off()