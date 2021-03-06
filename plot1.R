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

# aggregate emissions in Baltimore City,
totalEmissionsByYear <- aggregate(Emissions ~ year, NEI, sum)

# Create png file

barplot(height = totalEmissionsByYear$Emissions, names.arg = totalEmissionsByYear$year, xlab = "years", ylab = expression('Total PM'[2.5]*' Emission'), main = expression('Total PM'[2.5]*' by Year'))

dev.copy(png, file = "plot1.png")
dev.off()