library(ggplot2)

zipFile <- "exdata%2Fdata%2FNEI_data.zip"
unzip(zipFile, exdir="data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data\\summarySCC_PM25.rds")
SCC <- readRDS("data\\Source_Classification_Code.rds")

# Extract data for Baltimore City, Maryland for on road points
extractedData <- subset(NEI, (fips == "24510" | fips == "06037") & type == "ON-ROAD")

# Calculate the total for each year
aggregateResults <- aggregate(Emissions ~ year + fips, extractedData, sum)
aggregateResults$Country <- aggregateResults$fips == "24510" 

png('plot6.png')

g <- ggplot(aggregateResults, 
            aes(year, Emissions, color=fips)) +
    geom_line() +
    geom_point() +
    xlab("Year") +
    ylab("Total PM2.5 emission") +
    ggtitle('Motor vehicle emissions for motor vehicles sources in Baltimore City and Los Angeles County per year') +
    scale_colour_discrete(name="Country", labels=c("Los Angeles County","Baltimore City"))
                          
print(g)

dev.off()