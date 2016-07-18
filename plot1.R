setInternet2(TRUE)
options('download.file.method' = 'curl')

#Download the data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(URL, destfile = "./NEI_data.zip", method = "auto")

dateDownloaded <- date()

#Unzip the file
unzip("./NEI_data.zip", exdir = ".")

# Read in the datasets
# First check to see if the following files are in your directory using dir()
# dir()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totalEmissionsByYear <- aggregate(Emissions ~ year, NEI, sum)

#png('plot1.png')

barplot(height = totalEmissionsByYear$Emissions, names.arg = totalEmissionsByYear$year, xlab = "years", ylab = expression('Total PM'[2.5]*' Emission'), main = expression('Total PM'[2.5]*' by Year'))

dev.copy(png, file = "plot1.png")
dev.off()