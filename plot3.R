library(ggplot2)

zipFile <- "exdata%2Fdata%2FNEI_data.zip"
unzip(zipFile, exdir="data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data\\summarySCC_PM25.rds")
SCC <- readRDS("data\\Source_Classification_Code.rds")

# Extract data for Baltimore City, Maryland
baltimoreData <- subset(NEI, fips == 24510)

# Calculate the total for each year
aggregateResults <- aggregate(Emissions ~ year + type, baltimoreData, sum)

png('plot3.png')

g <- ggplot(aggregateResults, 
            aes(year, Emissions, color=type)) +
    geom_line() +
    geom_point() +
    xlab("Year") +
    ylab("Total PM2.5 emission") +
    ggtitle('Total PM2.5 emission per year and type for Baltimore City, Maryland')

print(g)

dev.off()