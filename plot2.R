zipFile <- "exdata%2Fdata%2FNEI_data.zip"
unzip(zipFile, exdir="data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data\\summarySCC_PM25.rds")
SCC <- readRDS("data\\Source_Classification_Code.rds")

# Extract data for Baltimore City, Maryland
baltimoreData <- subset(NEI, fips == 24510)

# Calculate the total for each year
aggregateResults <- aggregate(Emissions ~ year, baltimoreData, sum)

png('plot2.png')

# Create the graph
barplot(aggregateResults$Emissions, 
        names.arg=aggregateResults$year, 
        main="Total PM2.5 emission per year for Baltimore City, Maryland", 
        xlab="Year", 
        ylab="Total PM2.5 emission")

dev.off()