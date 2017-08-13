library(ggplot2)

zipFile <- "exdata%2Fdata%2FNEI_data.zip"
unzip(zipFile, exdir="data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data\\summarySCC_PM25.rds")
SCC <- readRDS("data\\Source_Classification_Code.rds")

# Extract data for Baltimore City, Maryland for on road points
extractedData <- subset(NEI, fips == 24510 & type == "ON-ROAD")

# Calculate the total for each year
aggregateResults <- aggregate(Emissions ~ year, extractedData, sum)

png('plot5.png')

g <- ggplot(aggregateResults, 
            aes(year, Emissions)) +
    geom_line() +
    geom_point() +
    xlab("Year") +
    ylab("Total PM2.5 emission") +
    ggtitle('Total PM2.5 emission from on-road sources in Baltimore City, Maryland per year')

print(g)

dev.off()