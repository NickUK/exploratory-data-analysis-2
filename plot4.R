library(ggplot2)

zipFile <- "exdata%2Fdata%2FNEI_data.zip"
unzip(zipFile, exdir="data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data\\summarySCC_PM25.rds")
SCC <- readRDS("data\\Source_Classification_Code.rds")

# Get coal related sources
coalRelatedSources <- SCC[grep("Coal", SCC$Short.Name, ignore.case=TRUE), ]
coalRelatedNEI <- subset(NEI, NEI$SCC %in% coalRelatedSources$SCC)

# Calculate the total for each year
aggregateResults <- aggregate(Emissions ~ year, coalRelatedNEI, sum)

png('plot4.png')

g <- ggplot(aggregateResults, 
            aes(year, Emissions)) +
    geom_line() +
    geom_point() +
    xlab("Year") +
    ylab("Total PM2.5 emission") +
    ggtitle('Total PM2.5 emission from coal sources per year')

print(g)

dev.off()