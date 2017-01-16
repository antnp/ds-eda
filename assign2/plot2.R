# plot2.R

setwd("~/Dropbox/code/coursera/ds-eda/assign2")

library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("./data/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
# SCC <- readRDS("./data/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Filter and group by maryland
by_year_fips <- NEI %>%
  group_by(year, fips) %>%
  filter(fips == "24510") %>%
  summarise(
    rec_count = n(),
    sum_emission = sum(Emissions)
  )

# Create plot with base graphics system
png('plot2.png')
barplot(by_year_fips$sum_emission, 
        names.arg=by_year_fips$year, 
        xlab="year", 
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions in Baltimore City, MD in select years'))
dev.off()
