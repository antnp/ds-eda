# plot1.R

setwd("~/Dropbox/code/coursera/ds-eda/assign2")

library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("./data/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
# SCC <- readRDS("./data/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all 
# sources for each of the years 1999, 2002, 2005, and 2008.

# Summarize the data by year
by_year <- group_by(NEI, year)
by_year_emission <- summarise(by_year,
                              rec_count = n(),
                              sum_emission = sum(Emissions)/1000 # kilotons for ease of reading
                              )

# Create plot with base graphics system
png('plot1.png')
barplot(by_year_emission$sum_emission, 
        names.arg=by_year_emission$year, 
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission in kilotons'),
        main=expression('Total PM'[2.5]*' emissions in select years'))
dev.off()
