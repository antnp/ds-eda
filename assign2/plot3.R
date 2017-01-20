# plot3.R

setwd("~/Dropbox/code/coursera/ds-eda/assign2")

library(dplyr)
library(ggplot2)

# Load data
NEI <- readRDS("./data/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Group data by year, fips, type
# filter for just Baltimore
by_year_fips_type <- NEI %>%
  group_by(year, fips, type) %>%
  filter(fips == "24510") %>%
  summarise(
    rec_count = n(),
    sum_emission = sum(Emissions)
  )

# Create plot
png('plot3.png')
ggplot(data = by_year_fips_type, aes(year, sum_emission, color = type)) + 
  geom_line() +
  xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle("Emissions by Type in Baltimore City, Maryland")
dev.off()
