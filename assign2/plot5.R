# plot5.R

setwd("~/Dropbox/code/coursera/ds-eda/assign2")

library(dplyr)
library(ggplot2)
library(stringr)

# Load data
NEI <- readRDS("./data/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Merge the NEI and SCC data
NEISCC <- merge(NEI, SCC, by = "SCC")

# confirm row count match
nrow(NEI) == nrow(NEISCC)

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Making assumption motor vehicle is type "ON-ROAD"

by_year_fips_type <- NEISCC %>%
  group_by(year, fips, type) %>%
  filter(fips == "24510" & type == "ON-ROAD") %>%
  summarise(
    rec_count = n(),
    sum_emission = sum(Emissions)
  )

# create plot

png("plot5.png")
ggplot(data = by_year_fips_type ,aes(year, sum_emission)) +
  geom_line() + geom_point() +
  xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Motor Vehicle Emissions for Baltimore City, MD")
dev.off()